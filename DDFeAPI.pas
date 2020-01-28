unit DDFeAPI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, IdHTTP, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack,
  IdSSL, IdSSLOpenSSL, ShellApi, IdCoderMIME, EncdDecd, principal, System.json;

// Assinatura das fun��es
function enviaConteudoParaAPI(conteudoEnviar, url, tpConteudo: String): String;
function manifestacao(CNPJInteressado, tpEvento, nsu: String;
  xJust: String = ''; chave: String = ''): String;
function tratamentoManifestacao(jsonRetorno: TJSONObject): String;
function downloadUnico(CNPJInteressado, caminho, tpAmb, nsu, modelo,
  chave: String; incluirPdf: boolean = false; apenasComXml: boolean = false;
  comEventos: boolean = false): String;
function downloadLote(CNPJInteressado, caminho, tpAmb, ultNSU, modelo: String;
  apenasPendManif: boolean = false; apenasComXml: boolean = false;
  comEventos: boolean = false; incluirPdf: boolean = false): String;
function downloadDocsLote(caminho: String; incluirPdf: boolean;
  jsonRetorno: TJSONObject): String;
function tratamentoDownloadLote(caminho: String; incluirPdf: boolean;
  jsonRetorno: TJSONObject): String;
function downloadDocUnico(caminho: String; incluirPdf: boolean;
  jsonRetorno: TJSONObject): String;
function tratamentoDownloadUnico(caminho: String; incluirPdf: boolean;
  jsonRetorno: TJSONObject): String;
function desacordoOperacao(CNPJInt, chCTe, tpAmb: String; xObs: String = ''): String;
function salvarXML(xml, caminho, chave: String; modelo: String = '55';
  tpEvento: String = ''): String;
function salvarPDF(pdf, caminho, chave: String; modelo: String = '55';
  tpEvento: String = ''): String;
procedure gravaLinhaLog(conteudo: String);

implementation

var
  // Onde deve por seu token
  token: String = 'SEU_TOKEN';

  // Fun��o gen�rica de envio para um url, contendo o token no header
function enviaConteudoParaAPI(conteudoEnviar, url, tpConteudo: String): String;
var
  retorno: String;
  conteudo: TStringStream;
  HTTP: TIdHTTP; // Dispon�vel na aba 'Indy Servers'
  IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
  // Disponivel na aba Indy I/O Handlers
begin
  conteudo := TStringStream.Create(conteudoEnviar, TEncoding.UTF8);
  HTTP := TIdHTTP.Create(nil);
  try
    if tpConteudo = 'txt' then // Informa que vai mandar um TXT
    begin
      HTTP.Request.ContentType := 'text/plain;charset=utf-8';
    end
    else if tpConteudo = 'xml' then // Se for XML
    begin
      HTTP.Request.ContentType := 'application/xml;charset=utf-8';
    end
    else // JSON
    begin
      HTTP.Request.ContentType := 'application/json;charset=utf-8';
    end;

    // Abre SSL
    IdSSLIOHandlerSocketOpenSSL1 := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    HTTP.IOHandler := IdSSLIOHandlerSocketOpenSSL1;

    // Avisa o uso de UTF-8
    HTTP.Request.ContentEncoding := 'UTF-8';

    // Adiciona o token ao header
    HTTP.Request.CustomHeaders.Values['X-AUTH-TOKEN'] := token;
    // Result := conteudo.ToString;
    // Faz o envio por POST do json para a url
    try
      retorno := HTTP.Post(url, conteudo);

    except
      on E: EIdHTTPProtocolException do
        retorno := E.ErrorMessage;
      on E: Exception do
        retorno := E.Message;
    end;

  finally
    conteudo.Free();
    HTTP.Free();
  end;

  // Devolve o json de retorno da API
  Result := retorno;
end;

// Fun��o onde � feita a requisi��o para uma manifesta��o
function manifestacao(CNPJInteressado, tpEvento, nsu: String;
  xJust: String = ''; chave: String = ''): String;
var
  url, resposta, json, status: String;
  jsonRetorno: TJSONObject;
begin
  if (nsu <> '') then
  begin
    json := '{"CNPJInteressado": "' + CNPJInteressado + '", ' + '"nsu": "' +
      nsu + '", ';
  end
  else
  begin
    json := '{"CNPJInteressado": "' + CNPJInteressado + '", ' + '"chave": "' +
      chave + '", ';
  end;

  json := json + '"manifestacao" : {' + '"tpEvento": "' + tpEvento + '"';

  if (tpEvento = '210240') then
  begin
    json := json + ', "xJust": "' + xJust + '"';
  end;
  json := json + '}}';

  url := 'https://ddfe.ns.eti.br/events/manif';

  gravaLinhaLog('[MANIFESTA��O_DADOS]');
  gravaLinhaLog(json);

  resposta := enviaConteudoParaAPI(json, url, 'json');

  gravaLinhaLog('[MANIFESTA��O_RESPOSTA]');
  gravaLinhaLog(resposta);

  jsonRetorno := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(resposta),
    0) as TJSONObject;

  tratamentoManifestacao(jsonRetorno);

  Result := resposta;
end;

// Fun��o que faz o tratamentos de uma Manifesta��o
function tratamentoManifestacao(jsonRetorno: TJSONObject): String;
var
  status: String;
  retEvento, erro: TJSONValue;
begin
  status := jsonRetorno.GetValue('status').Value;

  if (status = '200') then
  begin

    retEvento := jsonRetorno.Get('retEvento').JsonValue;
    jsonRetorno := TJSONObject.ParseJSONValue
      (TEncoding.ASCII.GetBytes(retEvento.ToString), 0) as TJSONObject;
    ShowMessage(jsonRetorno.GetValue('xMotivo').Value);

  end
  else if (status = '-3') then
  begin

    erro := jsonRetorno.Get('erro').JsonValue;
    jsonRetorno := TJSONObject.ParseJSONValue
      (TEncoding.ASCII.GetBytes(erro.ToString), 0) as TJSONObject;
    ShowMessage(jsonRetorno.GetValue('xMotivo').Value);

  end
  else
  begin

    ShowMessage(jsonRetorno.GetValue('motivo').Value);

  end;
end;

// Fun��o onde � feita a requisi��o para um downlaod unico
function downloadUnico(CNPJInteressado, caminho, tpAmb, nsu, modelo,
  chave: String; incluirPdf: boolean = false; apenasComXml: boolean = false;
  comEventos: boolean = false): String;
var
  json, tpEvento, url, resposta, tratamento, status: String;
  jsonRetorno: TJSONObject;
begin

  json := '{' + '"CNPJInteressado": "' + CNPJInteressado + '",';
  if (nsu <> '') then
  begin
    json := json + '"nsu": "' + nsu + '",' + '"modelo": "' + modelo + '",' +
      '"incluirPDF": ' + incluirPdf.ToInteger.ToString + ',' + '"tpAmb": "' +
      tpAmb + '"' + '}';
  end
  else
  begin
    json := json + '"chave": "' + chave + '",' + '"apenasComXml": ' +
      apenasComXml.ToInteger.ToString + ',' + '"comEventos": ' +
      comEventos.ToInteger.ToString + ',' + '"incluirPDF": ' +
      incluirPdf.ToInteger.ToString + ',' + '"tpAmb": "' + tpAmb + '"' + '}';
  end;

  url := 'https://ddfe.ns.eti.br/dfe/unique';

  gravaLinhaLog('[DOWNLOAD_UNICO_DADOS]');
  gravaLinhaLog(json);

  resposta := enviaConteudoParaAPI(json, url, 'json');

  gravaLinhaLog('[DOWNLOAD_UNICO_RESPOSTA]');
  gravaLinhaLog(resposta);

  jsonRetorno := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(resposta),
    0) as TJSONObject;

  tratamentoDownloadUnico(caminho, incluirPdf, jsonRetorno);

  Result := resposta;
end;

// Fun��o que faz o download do doc manifestado
function downloadDocUnico(caminho: String; incluirPdf: boolean;
  jsonRetorno: TJSONObject): String;
var
  i: integer;
  tpEvento, xml, pdf, listaDocs, chave, modelo: String;
  xmls: TJSONValue;
  xmlsArray: TJSONArray;
begin
  listaDocs := jsonRetorno.GetValue('listaDocs').Value;
  if (listaDocs = 'false') then
  begin
    xml := jsonRetorno.GetValue('xml').Value;
    chave := jsonRetorno.GetValue('chave').Value;
    modelo := jsonRetorno.GetValue('modelo').Value;
    salvarXML(xml, caminho, chave, modelo);

    if (incluirPdf = true) then
    begin
      pdf := jsonRetorno.GetValue('pdf').Value;
      salvarPDF(pdf, caminho, chave, modelo, tpEvento);
    end;
  end
  else
  begin
    xmls := jsonRetorno.Get('xmls').JsonValue;
    xmlsArray := xmls as TJSONArray;
    tpEvento := '';
    for i := 0 to xmlsArray.Size - 1 do
    begin
      if (i >= 1) then
      begin
        tpEvento := (xmlsArray.Get(i) as TJSONObject)
          .GetValue('tpEvento').Value;
      end;

      xml := (xmlsArray.Get(i) as TJSONObject).GetValue('xml').Value;
      chave := (xmlsArray.Get(i) as TJSONObject).GetValue('chave').Value;
      modelo := (xmlsArray.Get(i) as TJSONObject).GetValue('modelo').Value;
      salvarXML(xml, caminho, chave, modelo, tpEvento);

      if (incluirPdf = true) then
      begin
        pdf := (xmlsArray.Get(i) as TJSONObject).GetValue('pdf').Value;
        salvarPDF(pdf, caminho, chave, modelo, tpEvento);
      end;

    end;
  end;
end;

// Fun��o trata retorno do Download Unico
function tratamentoDownloadUnico(caminho: String; incluirPdf: boolean;
  jsonRetorno: TJSONObject): String;
var
  status: String;
begin
  status := jsonRetorno.GetValue('status').Value;

  if (status = '200') then
  begin
    downloadDocUnico(caminho, incluirPdf, jsonRetorno);
    ShowMessage('Download Unico feito com sucesso');
  end
  else
  begin
    ShowMessage(jsonRetorno.GetValue('motivo').Value);
  end;
end;

// Fun��o onde � feita a requisi��o para um download em lote
function downloadLote(CNPJInteressado, caminho, tpAmb, ultNSU, modelo: String;
  apenasPendManif: boolean = false; apenasComXml: boolean = false;
  comEventos: boolean = false; incluirPdf: boolean = false): String;
var
  arquivo: TextFile;
  jsonRetorno: TJSONObject;
  json, resposta, url, status: String;
begin

  if (apenasPendManif = true) then
  begin
    json := '{"CNPJInteressado": "' + CNPJInteressado + '", ' + '"ultNSU": ' +
      ultNSU + ', ' + '"modelo": "' + modelo + '", ' + '"tpAmb": "' + tpAmb +
      '", ' + '"incluirPDF": ' + incluirPdf.ToInteger.ToString + ', ' +
      '"apenasPendManif": ' + apenasPendManif.ToInteger.ToString + '}';
  end
  else
  begin
    json := '{"CNPJInteressado": "' + CNPJInteressado + '", ' + '"ultNSU": ' +
      ultNSU + ', ' + '"modelo": "' + modelo + '", ' + '"tpAmb": "' + tpAmb +
      '", ' + '"incluirPDF": ' + incluirPdf.ToInteger.ToString + ', ' +
      '"apenasComXml": ' + apenasComXml.ToInteger.ToString + ', ' +
      '"comEventos": ' + comEventos.ToInteger.ToString + '}';
  end;

  url := 'https://ddfe.ns.eti.br/dfe/bunch';

  gravaLinhaLog('[DOWNLOAD_LOTE_DADOS]');
  gravaLinhaLog(json);

  resposta := enviaConteudoParaAPI(json, url, 'json');

  gravaLinhaLog('[DOWNLOAD_LOTE_RESPOSTA]');
  gravaLinhaLog(resposta);

  jsonRetorno := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(resposta),
    0) as TJSONObject;

  tratamentoDownloadLote(caminho, incluirPdf, jsonRetorno);

  Result := resposta;
end;

// Fun��o que faz o download dos docs em lote
function downloadDocsLote(caminho: String; incluirPdf: boolean;
  jsonRetorno: TJSONObject): String;
var
  i: integer;
  tpEvento, xml, pdf, chave, modelo: String;
  xmls: TJSONValue;
  xmlsArray: TJSONArray;
begin
  xmls := jsonRetorno.Get('xmls').JsonValue;
  xmlsArray := xmls as TJSONArray;

  for i := 0 to xmlsArray.Size - 1 do
  begin
    tpEvento := '';
    xml := (xmlsArray.Get(i) as TJSONObject).GetValue('xml').Value;
    chave := (xmlsArray.Get(i) as TJSONObject).GetValue('chave').Value;
    modelo := (xmlsArray.Get(i) as TJSONObject).GetValue('modelo').Value;

    if Pos('tpEvento', (xmlsArray.Get(i) as TJSONObject).ToString) <> 0 then
    begin
      tpEvento := (xmlsArray.Get(i) as TJSONObject).GetValue('tpEvento').Value;
    end
    else
    begin
      if (incluirPdf = true) then
      begin
        pdf := (xmlsArray.Get(i) as TJSONObject).GetValue('pdf').Value;
        salvarPDF(pdf, caminho, chave, modelo, tpEvento);
      end;
    end;
    salvarXML(xml, caminho, chave, modelo, tpEvento);
  end;
  Result := jsonRetorno.GetValue('ultNSU').Value;
end;

// Fun��o trata retorno do Download em Lote
function tratamentoDownloadLote(caminho: String; incluirPdf: boolean;
  jsonRetorno: TJSONObject): String;
var
  status: String;
begin
  status := jsonRetorno.GetValue('status').Value;
  if (status = '200') then
  begin
    principal.frmPrincipal.lbUltNsu.Caption :=
      downloadDocsLote(caminho, incluirPdf, jsonRetorno);
    ShowMessage('Download em Lote feito com sucesso');
  end
  else
  begin
    ShowMessage(jsonRetorno.GetValue('motivo').Value);
  end;
end;

// Faz o desacorodo de opera��o de um CT-e
function desacordoOperacao(CNPJInt, chCTe, tpAmb: String; xObs: String = ''): String;
var
  arquivo: TextFile;
  jsonRetorno, erro: TJSONObject;
  json, resposta, url, status, data, hora, dhEvento: String;
begin
  data := FormatDateTime('yyyy-mm-dd', Now);
  hora := FormatDateTime('hh:MM:ss', Now);
  dhEvento := data + 'T' + hora + '-3:00';
  json := '{' +
          '"CNPJInteressado": "' + CNPJInt + '", ' +
          '"infEvento": {' +
            '"chCTe": "'   + chCTe + '", ' +
            '"tpAmb": "'    + tpAmb + '", ' +
            '"dhEvento": "' + dhEvento + '", ' +
            '"indDesacordooper": "1"';

  if (xObs <> '') then
  begin
    json := json + ', ' +
          '"xObs": "' + xObs + '"';
  end;
  json := json + '}}';

  url := 'https://ddfe.ns.eti.br/events/cte/disagree';

  gravaLinhaLog('[DESACORDO_OPERACAO_DADOS]');
  gravaLinhaLog(json);

  resposta := enviaConteudoParaAPI(json, url, 'json');

  gravaLinhaLog('[DESACORDO_OPERACAO_RESPOSTA]');
  gravaLinhaLog(resposta);

  jsonRetorno := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(resposta),
    0) as TJSONObject;
  status := jsonRetorno.GetValue('status').Value;
  if (status = '200') then
  begin
    ShowMessage('Download em Lote feito com sucesso');
  end
  else
  begin
    erro := jsonRetorno.Get('erro').JsonValue;
    jsonRetorno := TJSONObject.ParseJSONValue
      (TEncoding.ASCII.GetBytes(erro.ToString), 0) as TJSONObject;
    ShowMessage(jsonRetorno.GetValue('xMotivo').Value);
  end;
  Result := resposta;

end;

// Fun��o para salvar o XML de retorno
function salvarXML(xml, caminho, chave: String; modelo: String = '55';
  tpEvento: String = ''): String;
var
  arquivo: TextFile;
  conteudoSalvar, localParaSalvar, extencao: String;
begin

  if not DirectoryExists(caminho + '\xmls\') then
    CreateDir(caminho + '\xmls\');
  if (modelo = '55') then
  begin
    extencao := '-procNFe.xml';
  end
  else if (modelo = '57') then
  begin
    extencao := '-procCTe.xml';
  end
  else
  begin
    extencao := '-procNFSeSP.xml';
  end;

  // Seta o caminho para o arquivo XML
  localParaSalvar := caminho + '\xmls\' + tpEvento + chave + extencao;

  // Associa o arquivo ao caminho
  AssignFile(arquivo, localParaSalvar);
  // Abre para escrita o arquivo
  Rewrite(arquivo);

  // Copia o retorno
  conteudoSalvar := xml;
  // Ajeita o XML retirando as barras antes das aspas duplas
  conteudoSalvar := StringReplace(conteudoSalvar, '\"', '"',
    [rfReplaceAll, rfIgnoreCase]);

  // Escreve o retorno no arquivo
  Writeln(arquivo, conteudoSalvar);

  // Fecha o arquivo
  CloseFile(arquivo);
end;

// Fun��o para salvar o PDF de retorno
function salvarPDF(pdf, caminho, chave: String; modelo: String = '55';
  tpEvento: String = ''): String;
var
  conteudoSalvar, localParaSalvar, extencao: String;
  base64decodificado: TStringStream;
  arquivo: TFileStream;
begin
  if not DirectoryExists(caminho + '\pdfs\') then
    CreateDir(caminho + '\pdfs\');

  if (modelo = '55') then
  begin
    extencao := '-procNFe.pdf';
  end
  else if (modelo = '57') then
  begin
    extencao := '-procCTe.pdf';
  end
  else
  begin
    extencao := '-procNFSeSP.pdf';
  end;

  // Seta o caminho para o arquivo XML
  localParaSalvar := caminho + '\pdfs\' + tpEvento + chave + extencao;

  // Copia e cria uma TString com o base64
  conteudoSalvar := pdf;
  base64decodificado := TStringStream.Create(conteudoSalvar);

  // Cria o arquivo .pdf e decodifica o base64 para o arquivo
  try
    arquivo := TFileStream.Create(localParaSalvar, fmCreate);
    try
      DecodeStream(base64decodificado, arquivo);
    finally
      arquivo.Free;
    end;
  finally
    base64decodificado.Free;
  end;
end;

// Grava uma linha no log
procedure gravaLinhaLog(conteudo: String);
var
  caminhoEXE, nomeArquivo, data: String;
  log: TextFile;
begin
  // Pega o caminho do execut�vel
  caminhoEXE := ExtractFilePath(GetCurrentDir);
  caminhoEXE := caminhoEXE + 'log\';

  // Pega a data atual
  data := DateToStr(Date);

  // Ajeita o XML retirando as barras antes das aspas duplas
  data := StringReplace(data, '/', '', [rfReplaceAll, rfIgnoreCase]);

  nomeArquivo := caminhoEXE + data;

  // Se diret�rio \log n�o existe, � criado
  if not DirectoryExists(caminhoEXE) then
    CreateDir(caminhoEXE);

  AssignFile(log, nomeArquivo + '.txt');
{$I-}
  Reset(log);
{$I+}
  if (IOResult <> 0) then
    Rewrite(log) { arquivo n�o existe e ser� criado }
  else
  begin
    CloseFile(log);
    Append(log); { o arquivo existe e ser� aberto para sa�das adicionais }
  end;

  Writeln(log, DateTimeToStr(Now) + ' - ' + conteudo);

  CloseFile(log);
end;

end.

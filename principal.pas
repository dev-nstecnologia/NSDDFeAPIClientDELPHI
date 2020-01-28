unit principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TfrmPrincipal = class(TForm)
	  pgControl: TPageControl;
    Label4: TLabel;
    btnManifestacao: TButton;
    GroupBox4: TGroupBox;
    memoRetornoMani: TMemo;
    formUnico: TTabSheet;
    formLote: TTabSheet;
    Label7: TLabel;
    GroupBox1: TGroupBox;
    memoRetornoUniq: TMemo;
    Label8: TLabel;
    txtCNPJIntUniq: TEdit;
    Label9: TLabel;
    cbTpAmbUniq: TComboBox;
    cbDocUniq: TComboBox;
    Label10: TLabel;
    txtNumDocUniq: TEdit;
    btnDownUniq: TButton;
    txtCaminhoSalvarUniq: TEdit;
    Label6: TLabel;
    cbModeloUniq: TComboBox;
    chkApenasComXmlUniq: TCheckBox;
    Label11: TLabel;
    chkComEventosUniq: TCheckBox;
    cbIncluirPdfUniq: TCheckBox;
    btnDownLote: TButton;
    chkIncluirPdfLote: TCheckBox;
    cbModeloLote: TComboBox;
    cbTpAmbLote: TComboBox;
    chkApenasComXmlLote: TCheckBox;
    chkComEventosLote: TCheckBox;
    GroupBox2: TGroupBox;
    memoRetornoLote: TMemo;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    txtCaminhoSalvarLote: TEdit;
    txtUltNsuLote: TEdit;
    Label18: TLabel;
    chkCarregarPendLote: TCheckBox;
    lbUltNsu: TLabel;
    txtCNPJIntMani: TEdit;
    Label1: TLabel;
    cbTpAmbMani: TComboBox;
    Label12: TLabel;
    cbDocMani: TComboBox;
    txtNumDocMani: TEdit;
    cbTpEventoMani: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    txtXJustMani: TEdit;
    Label5: TLabel;
    txtCNPJIntLote: TEdit;
    TabSheet1: TTabSheet;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    cbtpAmbDesacordo: TComboBox;
    GroupBox3: TGroupBox;
    memoRetornoDesacordo: TMemo;
    txtCNPJIntDesacordo: TEdit;
    txtchCTeDesacordo: TEdit;
    btnDesacordo: TButton;
    txtxObsDesacordo: TEdit;
    procedure btnManifestacaoClick(Sender: TObject);
    procedure btnDownUniqClick(Sender: TObject);
    procedure btnDownLoteClick(Sender: TObject);
    procedure btnDesacordoClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses DDFeAPI;

procedure TfrmPrincipal.btnManifestacaoClick(Sender: TObject);
var
  retorno: String;
begin
  if ((txtCNPJIntMani.Text <> '') and
      (txtNumDocMani.Text <> '')) then
  begin
    memoRetornoMani.Lines.Clear;
    if (cbDocMani.Text = 'nsu') then
    begin
      retorno:= manifestacao(txtCNPJIntMani.Text, cbTpEventoMani.Text, txtNumDocMani.Text);
    end
    else
    begin
      retorno:= manifestacao(txtCNPJIntMani.Text, cbTpEventoMani.Text, '', txtXJustMani.Text,
      txtNumDocMani.Text);
    end;
    memoRetornoMani.Text := retorno;
  end
  else
  begin
    Showmessage('Todos os campos devem estar preenchidos');
  end;
end;

procedure TfrmPrincipal.btnDownUniqClick(Sender: TObject);

var
  retorno, apenasXml, eventos: String;
begin
  // Valida se todos os campos foram preenchidos
  if ((txtCaminhoSalvarUniq.Text <> '') and
      (txtCNPJIntUniq.Text <> '') and
      (txtNumDocUniq.Text <> '')) then
  begin
    memoRetornoUniq.Lines.Clear;
    if (cbDocUniq.Text = 'nsu') then
    begin
      retorno := downloadUnico(txtCNPJIntUniq.Text, txtCaminhoSalvarUniq.Text,
      cbTpAmbUniq.Text, txtNumDocUniq.Text, cbModeloUniq.Text, '', cbIncluirPdfUniq.Checked);
    end
    else
    begin
      retorno := downloadUnico(txtCNPJIntUniq.Text, txtCaminhoSalvarUniq.Text,
      cbTpAmbUniq.Text, '', cbModeloUniq.Text, txtNumDocUniq.Text, cbIncluirPdfUniq.Checked,
      chkApenasComXmlUniq.Checked,chkComEventosUniq.Checked);
    end;

    memoRetornoUniq.Text := retorno;
  end
  else
  begin
    Showmessage('Todos os campos devem estar preenchidos');
  end;
end;

procedure TfrmPrincipal.btnDownLoteClick(Sender: TObject);
var
  retorno, apenasXml, eventos: String;
begin
  // Valida se todos os campos foram preenchidos
  if ((txtCaminhoSalvarLote.Text <> '') and
      (txtCNPJIntLote.Text <> '') and
      (txtUltNsuLote.Text <> '')) then
  begin
    memoRetornoUniq.Lines.Clear;
    retorno := downloadLote(txtCNPJIntLote.Text, txtCaminhoSalvarLote.Text,
    cbTpAmbLote.Text, txtUltNsuLote.Text, cbModeloLote.Text, chkCarregarPendLote.Checked,
    chkApenasComXmlLote.Checked, chkComEventosLote.Checked, chkIncluirPdfLote.Checked);

    memoRetornoLote.Text := retorno;
  end
  else
  begin
    Showmessage('Todos os campos devem estar preenchidos');
  end;
end;

procedure TfrmPrincipal.btnDesacordoClick(Sender: TObject);
var
  retorno, apenasXml, eventos: String;
begin
  // Valida se todos os campos foram preenchidos
  if ((txtchCTeDesacordo.Text <> '') and
      (txtCNPJIntDesacordo.Text <> ''))then
  begin
    memoRetornoUniq.Lines.Clear;
    retorno := desacordoOperacao(txtCNPJIntDesacordo.Text, txtchCTeDesacordo.Text,
    cbtpAmbDesacordo.Text, txtxObsDesacordo.Text);

    memoRetornoDesacordo.Text := retorno;
  end
  else
  begin
    Showmessage('Todos os campos devem estar preenchidos');
  end;
end;
end.


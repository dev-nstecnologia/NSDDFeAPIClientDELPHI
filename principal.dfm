object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Exemplo DDF-e'
  ClientHeight = 609
  ClientWidth = 580
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pgControl: TPageControl
    Left = 0
    Top = 0
    Width = 580
    Height = 609
    ActivePage = TabSheet1
    Align = alCustom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object formManifestacao: TTabSheet
      Caption = 'Manifesta'#231#227'o'
      object Label4: TLabel
        Left = 244
        Top = 123
        Width = 303
        Height = 16
        Caption = 'Informar o xJust somente quando evento for 210240'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 34
        Top = 15
        Width = 131
        Height = 16
        Caption = 'CNPJ do Interessado:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label12: TLabel
        Left = 34
        Top = 89
        Width = 110
        Height = 16
        Caption = 'Tipo de Ambiente:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 34
        Top = 164
        Width = 98
        Height = 16
        Caption = 'Tipo de Evento :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 388
        Top = 6
        Width = 6
        Height = 25
        Caption = ':'
        Constraints.MaxWidth = 100
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 292
        Top = 155
        Width = 74
        Height = 16
        Caption = 'Justifica'#231#227'o:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object btnManifestacao: TButton
        Left = 21
        Top = 264
        Width = 516
        Height = 28
        Caption = 'Enviar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = btnManifestacaoClick
      end
      object GroupBox4: TGroupBox
        Left = 3
        Top = 311
        Width = 544
        Height = 212
        Caption = 'Retorno API'
        TabOrder = 1
        object memoRetornoMani: TMemo
          Left = 12
          Top = 24
          Width = 517
          Height = 177
          TabOrder = 0
        end
      end
      object txtCNPJIntMani: TEdit
        Left = 34
        Top = 37
        Width = 231
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object cbTpAmbMani: TComboBox
        Left = 34
        Top = 111
        Width = 143
        Height = 28
        Style = csDropDownList
        ItemIndex = 1
        TabOrder = 3
        Text = '2'
        Items.Strings = (
          '1'
          '2')
      end
      object cbDocMani: TComboBox
        Left = 315
        Top = 9
        Width = 67
        Height = 28
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 4
        Text = 'nsu'
        Items.Strings = (
          'nsu'
          'chave')
      end
      object txtNumDocMani: TEdit
        Left = 315
        Top = 37
        Width = 232
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object cbTpEventoMani: TComboBox
        Left = 34
        Top = 202
        Width = 143
        Height = 28
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 6
        Text = '210200'
        Items.Strings = (
          '210200'
          '210210'
          '210220'
          '210240')
      end
      object txtXJustMani: TEdit
        Left = 372
        Top = 152
        Width = 110
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
      end
    end
    object formUnico: TTabSheet
      Caption = 'Download '#218'nico'
      ImageIndex = 1
      object Label7: TLabel
        Left = 18
        Top = 79
        Width = 110
        Height = 16
        Caption = 'Tipo de Ambiente:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 18
        Top = 31
        Width = 131
        Height = 16
        Caption = 'CNPJ do Interessado:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 242
        Top = 271
        Width = 64
        Height = 16
        Caption = 'Salvar em:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label10: TLabel
        Left = 348
        Top = 72
        Width = 6
        Height = 25
        Caption = ':'
        Constraints.MaxWidth = 100
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 293
        Top = 31
        Width = 49
        Height = 16
        Caption = 'Modelo:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label11: TLabel
        Left = 42
        Top = 159
        Width = 474
        Height = 16
        Caption = 
          'Se selecionar chave ao inves de NSU, voc'#234' pode utilizar as segui' +
          'ntes fun'#231#245'es::'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object GroupBox1: TGroupBox
        Left = 3
        Top = 394
        Width = 544
        Height = 177
        Caption = 'Retorno API'
        TabOrder = 0
        object memoRetornoUniq: TMemo
          Left = 3
          Top = 29
          Width = 517
          Height = 145
          TabOrder = 0
        end
      end
      object txtCNPJIntUniq: TEdit
        Left = 155
        Top = 28
        Width = 110
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object cbTpAmbUniq: TComboBox
        Left = 134
        Top = 73
        Width = 131
        Height = 28
        Style = csDropDownList
        ItemIndex = 1
        TabOrder = 2
        Text = '2'
        Items.Strings = (
          '1'
          '2')
      end
      object cbDocUniq: TComboBox
        Left = 291
        Top = 73
        Width = 51
        Height = 28
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 3
        Text = 'nsu'
        Items.Strings = (
          'nsu'
          'chave')
      end
      object txtNumDocUniq: TEdit
        Left = 360
        Top = 76
        Width = 175
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object btnDownUniq: TButton
        Left = 18
        Top = 352
        Width = 516
        Height = 28
        Caption = 'Enviar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnClick = btnDownUniqClick
      end
      object txtCaminhoSalvarUniq: TEdit
        Left = 18
        Top = 301
        Width = 516
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object cbModeloUniq: TComboBox
        Left = 348
        Top = 25
        Width = 186
        Height = 28
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 7
        Text = '55'
        Items.Strings = (
          '55'
          '57'
          '98')
      end
      object chkApenasComXmlUniq: TCheckBox
        Left = 18
        Top = 197
        Width = 180
        Height = 17
        Caption = 'Apenas XMLs autorizados'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
      end
      object chkComEventosUniq: TCheckBox
        Left = 204
        Top = 197
        Width = 164
        Height = 17
        Caption = 'Incluir XMLs dos eventos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
      end
      object cbIncluirPdfUniq: TCheckBox
        Left = 384
        Top = 197
        Width = 148
        Height = 17
        Caption = 'Incluir PDF das Notas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
      end
    end
    object formLote: TTabSheet
      Caption = 'Donwload Lote'
      ImageIndex = 2
      object Label13: TLabel
        Left = 178
        Top = 225
        Width = 192
        Height = 16
        Caption = 'Numero do ultimo NSU baixado:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label14: TLabel
        Left = 334
        Top = 39
        Width = 49
        Height = 16
        Caption = 'Modelo:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label15: TLabel
        Left = 26
        Top = 87
        Width = 110
        Height = 16
        Caption = 'Tipo de Ambiente:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label16: TLabel
        Left = 26
        Top = 39
        Width = 131
        Height = 16
        Caption = 'CNPJ do Interessado:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label17: TLabel
        Left = 250
        Top = 279
        Width = 64
        Height = 16
        Caption = 'Salvar em:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label18: TLabel
        Left = 334
        Top = 87
        Width = 73
        Height = 16
        Caption = 'Ultimo NSU:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lbUltNsu: TLabel
        Left = 376
        Top = 225
        Width = 7
        Height = 16
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object btnDownLote: TButton
        Left = 26
        Top = 360
        Width = 516
        Height = 28
        Caption = 'Enviar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = btnDownLoteClick
      end
      object chkIncluirPdfLote: TCheckBox
        Left = 376
        Top = 133
        Width = 148
        Height = 17
        Caption = 'Incluir PDF das Notas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object cbModeloLote: TComboBox
        Left = 389
        Top = 33
        Width = 153
        Height = 28
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 2
        Text = '55'
        Items.Strings = (
          '55'
          '57'
          '98')
      end
      object cbTpAmbLote: TComboBox
        Left = 142
        Top = 81
        Width = 131
        Height = 28
        Style = csDropDownList
        ItemIndex = 1
        TabOrder = 3
        Text = '2'
        Items.Strings = (
          '1'
          '2')
      end
      object chkApenasComXmlLote: TCheckBox
        Left = 26
        Top = 133
        Width = 180
        Height = 17
        Caption = 'Apenas XMLs autorizados'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object chkComEventosLote: TCheckBox
        Left = 376
        Top = 173
        Width = 164
        Height = 17
        Caption = 'Incluir XMLs dos eventos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object GroupBox2: TGroupBox
        Left = 11
        Top = 397
        Width = 544
        Height = 177
        Caption = 'Retorno API'
        TabOrder = 6
        object memoRetornoLote: TMemo
          Left = 12
          Top = 24
          Width = 517
          Height = 145
          TabOrder = 0
        end
      end
      object txtCaminhoSalvarLote: TEdit
        Left = 26
        Top = 309
        Width = 516
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
      end
      object txtCNPJIntLote: TEdit
        Left = 163
        Top = 36
        Width = 110
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
      end
      object txtUltNsuLote: TEdit
        Left = 413
        Top = 84
        Width = 130
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
      end
      object chkCarregarPendLote: TCheckBox
        Left = 26
        Top = 173
        Width = 231
        Height = 17
        Caption = 'Carregar apenas docs pendentes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Desacordo'
      ImageIndex = 3
      object Label20: TLabel
        Left = 43
        Top = 79
        Width = 42
        Height = 16
        Caption = 'Chave:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label21: TLabel
        Left = 330
        Top = 55
        Width = 110
        Height = 16
        Caption = 'Tipo de Ambiente:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label22: TLabel
        Left = 43
        Top = 31
        Width = 131
        Height = 16
        Caption = 'CNPJ do Interessado:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label23: TLabel
        Left = 171
        Top = 159
        Width = 216
        Height = 16
        Caption = 'Observa'#231#227'o do Tomador(opcional):'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object cbtpAmbDesacordo: TComboBox
        Left = 454
        Top = 55
        Width = 35
        Height = 28
        Style = csDropDownList
        ItemIndex = 1
        TabOrder = 0
        Text = '2'
        Items.Strings = (
          '1'
          '2')
      end
      object GroupBox3: TGroupBox
        Left = 19
        Top = 397
        Width = 544
        Height = 177
        Caption = 'Retorno API'
        TabOrder = 1
        object memoRetornoDesacordo: TMemo
          Left = 12
          Top = 24
          Width = 517
          Height = 145
          TabOrder = 0
        end
      end
      object txtCNPJIntDesacordo: TEdit
        Left = 180
        Top = 28
        Width = 117
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object txtchCTeDesacordo: TEdit
        Left = 91
        Top = 76
        Width = 206
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object btnDesacordo: TButton
        Left = 31
        Top = 363
        Width = 516
        Height = 28
        Caption = 'Enviar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnClick = btnDesacordoClick
      end
      object txtxObsDesacordo: TEdit
        Left = 32
        Top = 213
        Width = 516
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
    end
  end
end

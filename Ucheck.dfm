object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'JBCheckSum'
  ClientHeight = 229
  ClientWidth = 488
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 45
    Width = 240
    Height = 13
    Caption = 'Informe um diret'#243'rio ou clique no bot'#227'o selecionar'
  end
  object Label2: TLabel
    Left = 24
    Top = 97
    Width = 48
    Height = 13
    Caption = 'Hash MD5'
  end
  object lblValidor: TLabel
    Left = 67
    Top = 185
    Width = 3
    Height = 13
  end
  object Label3: TLabel
    Left = 405
    Top = 209
    Width = 75
    Height = 13
    Caption = 'By BoscoBecker'
    Color = clBtnShadow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGrayText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object editArquivo: TEdit
    Left = 24
    Top = 64
    Width = 281
    Height = 21
    TabOrder = 0
  end
  object Button1: TButton
    Left = 320
    Top = 55
    Width = 112
    Height = 40
    Caption = 'Selecionar Arquivo'
    TabOrder = 1
    OnClick = Button1Click
  end
  object editResult: TEdit
    Left = 23
    Top = 116
    Width = 281
    Height = 21
    ReadOnly = True
    TabOrder = 2
  end
  object ckComparer: TCheckBox
    Left = 335
    Top = 117
    Width = 66
    Height = 19
    Caption = 'Comparar'
    TabOrder = 3
    OnClick = ckComparerClick
  end
  object edtComparar: TEdit
    Left = 24
    Top = 158
    Width = 281
    Height = 21
    TabOrder = 4
    Visible = False
    OnChange = edtCompararChange
    OnClick = edtCompararClick
    OnExit = edtCompararExit
  end
  object OpenDialog1: TOpenDialog
    Left = 312
    Top = 24
  end
end

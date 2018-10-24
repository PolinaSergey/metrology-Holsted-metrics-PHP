object FMain: TFMain
  Left = 197
  Top = 388
  BorderStyle = bsSingle
  Caption = 'Main'
  ClientHeight = 612
  ClientWidth = 818
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object SGOperands: TStringGrid
    Left = 416
    Top = 88
    Width = 390
    Height = 425
    ColCount = 3
    FixedCols = 0
    RowCount = 2
    TabOrder = 0
    ColWidths = (
      51
      272
      59)
  end
  object SGOperators: TStringGrid
    Left = 8
    Top = 88
    Width = 390
    Height = 425
    ColCount = 3
    FixedCols = 0
    RowCount = 2
    ParentShowHint = False
    ShowHint = False
    TabOrder = 1
    ColWidths = (
      49
      268
      66)
  end
  object SG3Lines: TStringGrid
    Left = 8
    Top = 523
    Width = 800
    Height = 78
    ColCount = 2
    DefaultColWidth = 397
    FixedCols = 0
    RowCount = 3
    FixedRows = 0
    TabOrder = 2
    RowHeights = (
      24
      24
      24)
  end
  object BMain: TButton
    Left = 272
    Top = 16
    Width = 297
    Height = 49
    Caption = #1054#1090#1082#1088#1099#1090#1100' '#1092#1072#1081#1083' '#1089' '#1080#1089#1093#1086#1076#1085#1099#1084' '#1082#1086#1076#1086#1084
    TabOrder = 3
    OnClick = BMainClick
  end
  object DOMain: TOpenDialog
    Filter = #1048#1089#1093#1086#1076#1085#1099#1081' '#1082#1086#1076'|*.txt'
    Left = 56
    Top = 8
  end
end

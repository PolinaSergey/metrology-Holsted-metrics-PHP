unit UMetrika;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Math;

type
  SetKit = Set of Char;

  TFMain = class(TForm)
    SGOperands: TStringGrid;
    SGOperators: TStringGrid;
    SG3Lines: TStringGrid;
    DOMain: TOpenDialog;
    BMain: TButton;
    procedure BMainClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);

  private
    procedure Heart(var F: Text);
    procedure WordCreate (var Str, Word: String; Kit: SetKit);
    procedure InputOfTheWord (var Word: string; Table: TStringGrid);
  public
    { Public declarations }

  end;

var
  FMain: TFMain;

  F: Text;

  Str, Word: String;

  i: Integer;

implementation

{$R *.dfm}

procedure TFMain.InputOfTheWord(var Word: string; Table: TStringGrid);
begin
  i:=2;
  while (Word <> Table.Cells[1,i-1]) and (i<Table.RowCount) do
    Inc(i);
  if i<Table.RowCount then
    Table.Cells[2,i-1] := IntToStr(StrToInt(Table.Cells[2,i-1]) + 1)
  else
  begin
    Table.Cells[0,i-1]:=IntToStr(i-1);
    Table.Cells[1,i-1]:=Word;
    Table.Cells[2,i-1] := '1';
    Table.RowCount:=i+1;
  end;

end;

procedure TFMain.Heart(var F: Text);
begin
  Reset(F);
  SGOperators.RowCount:=2;
  SGOperands.RowCount:=2;
  SGOperators.Cells[1,1]:='';
  SGOperands.Cells[1,1]:='';

  while not Eof(F) do
  begin
    Readln(F,Str);

    while Length(Str) > 0 do
    case Str[1] of
      ' ', '}', ')',
      ','           : Delete(Str,1,1);

      'A'..'Z',
      'a'..'z', '_' : begin
                        WordCreate(Str,Word,['A'..'Z','a'..'z','_','0'..'9']);
                        Delete(Str,1,Length(Word));
                        if (Word = 'andfor') or ('andwhile' = Word) or (Word = 'case') or ('else' = Word) then
                        else
                          if (Word = 'and') or ('or' = Word) or (Word = 'xor') or (Word = 'breake') or ('continue' = Word) or ('return' = Word) or (Word = 'as') then
                            InputOfTheWord(Word,SGOperators)
                          else
                          begin
                            Delete(Str,1,Pos('(',Str));
                            Word:=Word+'()';
                            InputOfTheWord(Word,SGOperators);
                          end;
                      end;

      '$'           : begin
                        Delete(Str,1,1);
                        WordCreate(Str,Word,['A'..'Z','a'..'z', '_','0'..'9']);
                        Delete(Str,1,Length(Word));
                        InputOfTheWord(Word,SGOperands)
                      end;

      '.', ';', '(',
      '{', ':', '^',
      '@', '~', '%' : begin
                        Word:= Copy(Str,1,1);
                        Delete (Str, 1, 1);
                        if Word[1] = '(' then
                          Word:=Word+')';
                        if Word[1] = '{' then
                          Word:=Word+'}';  
                        InputOfTheWord(Word,SGOperators)
                      end;

      '=', '<', '>', '!' : begin
                        if Str[2] in ['=','<', '>'] then
                          begin
                            Word := Copy(Str,1,2);
                            Delete(Str,1,2);
                          end
                        else
                          begin
                           Word := Copy(Str,1,1);
                           Delete(Str,1,1);
                          end;
                        InputOfTheWord(Word,SGOperators)
                      end;

      '+', '-', '*',
      '&', '|'      : begin
                        if Str[2] in ['+', '-', '*', '&', '|'] then
                          begin
                            Word := Copy(Str,1,2);
                            Delete(Str,1,2);
                          end
                        else
                          begin
                           Word := Copy(Str,1,1);
                           Delete(Str,1,1);
                          end;
                        InputOfTheWord(Word,SGOperators)
                      end;

      '0'..'9'      : begin
                        WordCreate(Str,Word,['0'..'9']);
                        Delete(Str,1,Length(Word));
                        InputOfTheWord(Word,SGOperands)
                      end;

      '/'           : case Str[2] of
                        '/' : Str:='';
                        '*' : begin
                                Delete(Str,1,2);
                                while Pos('*/',Str)=0 do
                                  Readln(F,Str);
                                Delete(Str,1,Pos('*/',Str)+1);
                              end;
                      else
                        begin
                          Word:= Copy(Str,1,1);
                          Delete (Str, 1, 1);
                          InputOfTheWord(Word,SGOperators)
                        end
                      end;

      '''', '"'      : begin
                         Word:=Copy(Str,1,1);
                         Delete(Str,1,1);
                         Word:=Word+Copy(Str,1,Pos(Word[1],Str));
                         Delete(Str,1,Pos(Word[1],Str));
                         if Word[1]='"' then
                         begin
                           Word[1]:='''';
                           Word[Length(Word)]:=''''
                         end;
                         InputOfTheWord(Word,SGOperands);
                       end

    else Delete(Str,1,1)
    end;
  end;

  CloseFile(F);


  SGOperands.Cells[2,SGOperands.RowCount-1] := '0';
  SGOperators.Cells[2,SGOperators.RowCount-1] := '0';

  for i:=1 to SGOperators.RowCount-2 do
    SGOperators.Cells[2,SGOperators.RowCount-1] := IntToStr(StrToInt(SGOperators.Cells[2,SGOperators.RowCount-1])+StrToInt(SGOperators.Cells[2,i]));
  for i:=1 to SGOperands.RowCount-2 do
    SGOperands.Cells[2,SGOperands.RowCount-1] := IntToStr(StrToInt(SGOperands.Cells[2,SGOperands.RowCount-1])+StrToInt(SGOperands.Cells[2,i]));


  SG3Lines.Cells[1,0]:='n='+inttostr(SGOperators.RowCount-2)+'+'+inttostr(SGOperands.RowCount-2)+'='+inttostr(SGOperators.RowCount-2+SGOperands.RowCount);
  SG3Lines.Cells[1,1]:='N='+SGOperators.Cells[2,SGOperators.RowCount-1]+'+'+SGOperands.Cells[2,SGOperands.RowCount-1]+'='+inttostr(StrToInt(SGOperators.Cells[2,SGOperators.RowCount-1])+StrToInt(SGOperands.Cells[2,SGOperands.RowCount-1]));
  SG3Lines.Cells[1,2]:='V='+inttostr(StrToInt(SGOperators.Cells[2,SGOperators.RowCount-1])+StrToInt(SGOperands.Cells[2,SGOperands.RowCount-1]))+'log2('+inttostr(SGOperators.RowCount-2+SGOperands.RowCount)+')='+inttostr(round((StrToInt(SGOperators.Cells[2,SGOperators.RowCount-1])+StrToInt(SGOperands.Cells[2,SGOperands.RowCount-1]))*log2(SGOperators.RowCount-2+SGOperands.RowCount)));

  SGOperands.Cells[0,SGOperands.RowCount-1]  := 'n2=' + inttostr(SGOperands.RowCount-2);
  SGOperators.Cells[0,SGOperators.RowCount-1] := 'n1=' + inttostr(SGOperators.RowCount-2);
  SGOperands.Cells[2,SGOperands.RowCount-1] := 'N2='+SGOperands.Cells[2,SGOperands.RowCount-1];
  SGOperators.Cells[2,SGOperators.RowCount-1] := 'N1='+SGOperators.Cells[2,SGOperators.RowCount-1];
end;

procedure TFMain.WordCreate (var Str, Word: String; Kit: SetKit);
begin
  i := 1;
  while Str[i] in Kit do
    inc(i);
  Word := Copy(Str,1,i-1);
end;

procedure TFMain.BMainClick(Sender: TObject);
begin
  if DOMain.Execute then
  begin 
    AssignFile(F,DOMain.FileName);
    Heart(F)
  end
end;

procedure TFMain.FormActivate(Sender: TObject);
begin
  SGOperators.Cells[0,0]:='j';
  SGOperators.Cells[1,0]:='Оператор';
  SGOperators.Cells[2,0]:='f1j';
  SGOperands.Cells[0,0]:='i';
  SGOperands.Cells[1,0]:='Операнд';
  SGOperands.Cells[2,0]:='f2i';

  SG3Lines.Cells[0,0]:='Словарь программы';
  SG3Lines.Cells[0,1]:='Длина программы';
  SG3Lines.Cells[0,2]:='Объем программы';
end;

end.

unit CocoBase;
{Base components for Coco/R for Delphi grammars for use with version 1.1}

interface
{$WARN IMPLICIT_STRING_CAST OFF}
{$I FFDEFINE.INC}

uses
  Classes, SysUtils;

const
  setsize = 16; { sets are stored in 16 bits }

  { Standard Error Types }
  etSyntax = 0;
  etSymantic = 1;

  chCR = #13;
  chLF = #10;
  chEOL = chCR + chLF;  { End of line characters for Microsoft Windows }
  chLineSeparator = chCR;

type
  ECocoBookmark = class(Exception);
  TCocoStatusType = (cstInvalid, cstBeginParse, cstEndParse, cstLineNum, cstString);
  TCocoError = class(TObject)
  private
    FErrorCode : integer;
    FCol : integer;
    FLine : integer;
    FData : AnsiString;
    FErrorType : integer;
  public
    property ErrorType : integer read FErrorType write FErrorType;
    property ErrorCode : integer read FErrorCode write FErrorCode;
    property Line : integer read FLine write FLine;
    property Col : integer read FCol write FCol;
    property Data : AnsiString read FData write FData;
  end; {TCocoError}

  TCommentItem = class(TObject)
  private
    fComment: AnsiString;
    fLine: integer;
    fColumn: integer;
  public
    property Comment : AnsiString read fComment write fComment;
    property Line : integer read fLine write fLine;
    property Column : integer read fColumn write fColumn;
  end; {TCommentItem}

  TCommentList = class(TObject)
  private
    fList : TList;

    function FixComment(const S : AnsiString) : AnsiString;
    function GetComments(Idx: integer): AnsiString;
    procedure SetComments(Idx: integer; const Value: AnsiString);
    function GetCount: integer;
    function GetText: AnsiString;
    function GetColumn(Idx: integer): integer;
    function GetLine(Idx: integer): integer;
    procedure SetColumn(Idx: integer; const Value: integer);
    procedure SetLine(Idx: integer; const Value: integer);
  public
    constructor Create;
    destructor Destroy; override;

    procedure Clear;
    procedure Add(const S : AnsiString; const aLine : integer; const aColumn : integer);
    property Comments[Idx : integer] : AnsiString read GetComments write SetComments; default;
    property Line[Idx : integer] : integer read GetLine write SetLine;
    property Column[Idx : integer] : integer read GetColumn write SetColumn;
    property Count : integer read GetCount;
    property Text : AnsiString read GetText;
  end; {TCommentList}

  TSymbolPosition = class(TObject)
  private
    fLine : integer;
    fCol : integer;
    fLen : integer;
    fPos : integer;
  public
    procedure Clear;
    procedure Assign(Source : TSymbolPosition);

    property Line : integer read fLine write fLine; {line of symbol}
    property Col : integer read fCol write fCol; {column of symbol}
    property Len : integer read fLen write fLen; {length of symbol}
    property Pos : integer read fPos write fPos; {file position of symbol}
  end; {TSymbolPosition}

  TGenListType = (glNever, glAlways, glOnError);

  TBitSet = set of 0..15;
  PStartTable = ^TStartTable;
  TStartTable = array[0..255] of integer;
  TCharSet = set of AnsiChar;

  TAfterGenListEvent = procedure(Sender : TObject;
    var PrintErrorCount : boolean) of object;
  TAfterGrammarGetEvent = procedure(Sender : TObject;
    var CurrentInputSymbol : integer) of object;
  TCommentEvent = procedure(Sender : TObject; CommentList : TCommentList) of object;
  TCustomErrorEvent = function(Sender : TObject; const ErrorCode : longint;
    const Data : String) : String of object;
  TErrorEvent = procedure(Sender : TObject; Error : TCocoError) of object;
  TErrorProc = procedure(ErrorCode : integer; Symbol : TSymbolPosition;
    Data : AnsiString; ErrorType : integer) of object;
  TFailureEvent = procedure(Sender : TObject; NumErrors : integer) of object;
  TGetCH = function(pos : longint) : AnsiChar of object;
  TStatusUpdateProc = procedure(Sender : TObject;
      const StatusType : TCocoStatusType;
      const Status : AnsiString;
      const LineNum : integer) of object;

  TCocoRScanner = class(TObject)
  private
    FbpCurrToken : integer; {position of current token)}
    FBufferPosition : integer; {current position in buf }
    FContextLen : integer; {length of appendix (CONTEXT phrase)}
    FCurrentCh : TGetCH; {procedural variable to get current input character}
    FCurrentSymbol : TSymbolPosition; {position of the current symbol in the source stream}
    FCurrInputCh : AnsiChar; {current input character}
    FCurrLine : integer; {current input line (may be higher than line)}
    FLastInputCh : AnsiChar; {the last input character that was read}
    FNextSymbol : TSymbolPosition; {position of the next symbol in the source stream}
    FNumEOLInComment : integer; {number of _EOLs in a comment}
    FOnStatusUpdate : TStatusUpdateProc;
    FScannerError : TErrorProc;
    FSourceLen : integer; {source file size}
    FSrcStream : TMemoryStream; {source memory stream}
    FStartOfLine : integer;

    function GetNStr(Symbol : TSymbolPosition; ChProc : TGetCh) : AnsiString;
    function ExtractBookmarkChar(var aBookmark: String): Char;
  protected
    FStartState : TStartTable; {start state for every character}

    function Bookmark : String; virtual;
    procedure GotoBookmark(aBookmark : String); virtual;

    function CapChAt(pos : longint) : AnsiChar;
    procedure Get(var sym : integer); virtual; abstract;
    procedure NextCh; virtual; abstract;

    function GetStartState : PStartTable;
    procedure SetStartState(aStartTable : PStartTable);

    property bpCurrToken : integer read fbpCurrToken write fbpCurrToken;
    property BufferPosition : integer read fBufferPosition write fBufferPosition;
    property ContextLen : integer read fContextLen write fContextLen;
    property CurrentCh : TGetCh read fCurrentCh write fCurrentCh;
    property CurrentSymbol : TSymbolPosition read fCurrentSymbol write fCurrentSymbol;
    property CurrInputCh : AnsiChar read fCurrInputCh write fCurrInputCh;
    property CurrLine : integer read fCurrLine write fCurrLine;
    property LastInputCh : AnsiChar read fLastInputCh write fLastInputCh;
    property NextSymbol : TSymbolPosition read fNextSymbol write fNextSymbol;
    property NumEOLInComment : integer read fNumEOLInComment write fNumEOLInComment;
    property OnStatusUpdate : TStatusUpdateProc read FOnStatusUpdate write FOnStatusUpdate;
    property ScannerError : TErrorProc read FScannerError write FScannerError;
    property SourceLen : integer read fSourceLen write fSourceLen;
    property SrcStream : TMemoryStream read fSrcStream write fSrcStream;
    property StartOfLine : integer read fStartOfLine write fStartOfLine;
    property StartState : PStartTable read GetStartState write SetStartState;
  public
    constructor Create;
    destructor Destroy; override;

    function CharAt(pos : longint) : AnsiChar;
    function GetName(Symbol : TSymbolPosition) : AnsiString; // Retrieves name of symbol of length len at position pos in source file
    function GetString(Symbol : TSymbolPosition) : AnsiString; // Retrieves exact String of max length len from position pos in source file
    procedure _Reset;
  end; {TCocoRScanner}

  TCocoRGrammar = class(TComponent)
  private
    fAfterGet: TAfterGrammarGetEvent;
    FAfterGenList : TAfterGenListEvent;
    FAfterParse : TNotifyEvent;
    FBeforeGenList : TNotifyEvent;
    FBeforeParse : TNotifyEvent;
    fClearSourceStream : boolean;
    FErrDist : integer; // number of symbols recognized since last error
    FErrorList : TList;
    fGenListWhen : TGenListType;
    FListStream : TMemoryStream;
    FOnCustomError : TCustomErrorEvent;
    FOnError : TErrorEvent;
    FOnFailure : TFailureEvent;
    FOnStatusUpdate : TStatusUpdateProc;
    FOnSuccess : TNotifyEvent;
    FScanner : TCocoRScanner;
    FSourceFileName : AnsiString;
    fExtra : integer;

    function GetSourceStream : TMemoryStream;
    function GetSuccessful : boolean;
    procedure SetOnStatusUpdate(const Value : TStatusUpdateProc);
    procedure SetSourceStream(const Value : TMemoryStream);
    function GetLineCount: integer;
    function GetCharacterCount: integer;
  protected
    fCurrentInputSymbol : integer; // current input symbol

    function Bookmark : AnsiString; virtual;
    procedure GotoBookmark(aBookmark : AnsiString); virtual;

    procedure ClearErrors;
    function ErrorStr(const ErrorCode: integer; const Data: String): String; virtual; abstract;
    procedure Expect(n : integer);
    procedure GenerateListing;
    procedure Get; virtual; abstract;
    procedure PrintErr(line : AnsiString; ErrorCode, col : integer;
      Data : AnsiString);
    procedure StoreError(nr : integer; Symbol : TSymbolPosition;
      Data : AnsiString; ErrorType : integer);

    procedure DoAfterParse; virtual;
    procedure DoBeforeParse; virtual;

    property ClearSourceStream : boolean read fClearSourceStream write fClearSourceStream default true;
    property CurrentInputSymbol : integer read fCurrentInputSymbol write fCurrentInputSymbol;
    property ErrDist : integer read fErrDist write fErrDist; // number of symbols recognized since last error
    property ErrorList : TList read FErrorList write FErrorList;
    property Extra : integer read fExtra write fExtra;
    property GenListWhen : TGenListType read fGenListWhen write fGenListWhen default glOnError;
    property ListStream : TMemoryStream read FListStream write FListStream;
    property SourceFileName : AnsiString read FSourceFileName write FSourceFileName;
    property SourceStream : TMemoryStream read GetSourceStream write SetSourceStream;
    property Successful : boolean read GetSuccessful;

    {Events}
    property AfterParse : TNotifyEvent read fAfterParse write fAfterParse;
    property AfterGenList : TAfterGenListEvent read fAfterGenList write fAfterGenList;
    property AfterGet : TAfterGrammarGetEvent read fAfterGet write fAfterGet;
    property BeforeGenList : TNotifyEvent read fBeforeGenList write fBeforeGenList;
    property BeforeParse : TNotifyEvent read fBeforeParse write fBeforeParse;
    property OnCustomError : TCustomErrorEvent read FOnCustomError write FOnCustomError;
    property OnError : TErrorEvent read fOnError write fOnError;
    property OnFailure : TFailureEvent read FOnFailure write FOnFailure;
    property OnStatusUpdate : TStatusUpdateProc read FOnStatusUpdate write SetOnStatusUpdate;
    property OnSuccess : TNotifyEvent read FOnSuccess write FOnSuccess;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    procedure GetLine(var pos : Integer; var line : AnsiString;
      var eof : boolean);
    function LexName : AnsiString;
    function LexString : AnsiString;
    function LookAheadName : AnsiString;
    function LookAheadString : AnsiString;
    procedure _StreamLine(s : AnsiString);
    procedure _StreamLn(s : AnsiString);
    procedure SemError(const errNo : integer; const Data : AnsiString);
    procedure SynError(const errNo : integer);

    property Scanner : TCocoRScanner read fScanner write fScanner;
    property LineCount : integer read GetLineCount;
    property CharacterCount : integer read GetCharacterCount;
  end; {TCocoRGrammar}

const
  _EF = #0;
  _TAB = #09;
  _CR = #13;
  _LF = #10;
  _EL = _CR;
  _EOF = #26; {MS-DOS eof}
  LineEnds : TCharSet = [_CR, _LF, _EF];
  { not only for errors but also for not finished states of scanner analysis }
  minErrDist = 2; { minimal distance (good tokens) between two errors }

function PadL(S : AnsiString; ch : AnsiChar; L : integer) : AnsiString;
function StrTok(var Text : AnsiString; const ch : AnsiChar) : AnsiString; overload;
function StrTok(var Text : String; const ch : Char) : String; overload;
implementation

const
  INVALID_CHAR = 'Invalid Coco/R for Delphi bookmark character';
  INVALID_INTEGER = 'Invalid Coco/R for Delphi bookmark integer';
  BOOKMARK_STR_SEPARATOR = ' ';

function PadL(S : AnsiString; ch : AnsiChar; L : integer) : AnsiString;
var
  i : integer;
begin
  for i := 1 to L - (Length(s)) do
    s := ch + s;
  Result := s;
end; {PadL}

function StrTok(var Text : AnsiString; const ch : AnsiChar) : AnsiString;
var
  apos : integer;
begin
  apos := Pos(ch, Text);
  if (apos > 0) then
  begin
    Result := Copy(Text, 1, apos - 1);
    Delete(Text, 1, apos);
  end
  else
  begin
    Result := Text;
    Text := '';
  end;
end; {StrTok}

function StrTok(var Text : String; const ch : Char) : String;
var
  apos : integer;
begin
  apos := Pos(ch, Text);
  if (apos > 0) then
  begin
    Result := Copy(Text, 1, apos - 1);
    Delete(Text, 1, apos);
  end
  else
  begin
    Result := Text;
    Text := '';
  end;
end; {StrTok}


{ TSymbolPosition }

procedure TSymbolPosition.Assign(Source: TSymbolPosition);
begin
  fLine := Source.fLine;
  fCol := Source.fCol;
  fLen := Source.fLen;
  fPos := Source.fPos;
end; {Assign}

procedure TSymbolPosition.Clear;
begin
  fLen := 0;
  fPos := 0;
  fLine := 0;
  fCol := 0;
end; { Clear }

{ TCocoRScanner }

function TCocoRScanner.Bookmark: String;
begin
  Result := IntToStr(bpCurrToken) + BOOKMARK_STR_SEPARATOR
      + IntToStr(BufferPosition) + BOOKMARK_STR_SEPARATOR
      + IntToStr(ContextLen) + BOOKMARK_STR_SEPARATOR
      + IntToStr(CurrLine) + BOOKMARK_STR_SEPARATOR
      + IntToStr(NumEOLInComment) + BOOKMARK_STR_SEPARATOR
      + IntToStr(StartOfLine) + BOOKMARK_STR_SEPARATOR
      + IntToStr(CurrentSymbol.Line) + BOOKMARK_STR_SEPARATOR
      + IntToStr(CurrentSymbol.Col) + BOOKMARK_STR_SEPARATOR
      + IntToStr(CurrentSymbol.Len) + BOOKMARK_STR_SEPARATOR
      + IntToStr(CurrentSymbol.Pos) + BOOKMARK_STR_SEPARATOR
      + IntToStr(NextSymbol.Line) + BOOKMARK_STR_SEPARATOR
      + IntToStr(NextSymbol.Col) + BOOKMARK_STR_SEPARATOR
      + IntToStr(NextSymbol.Len) + BOOKMARK_STR_SEPARATOR
      + IntToStr(NextSymbol.Pos) + BOOKMARK_STR_SEPARATOR
      + CurrInputCh
      + LastInputCh
end; {Bookmark}

function TCocoRScanner.ExtractBookmarkChar(var aBookmark : String) : Char;
begin
  if length(aBookmark) > 0 then
    Result := aBookmark[1]
  else
    Raise ECocoBookmark.Create(INVALID_CHAR);
end; {ExtractBookmarkChar}

procedure TCocoRScanner.GotoBookmark(aBookmark: String);
var
  BookmarkToken : String;
begin
  try
    BookmarkToken := StrTok(aBookmark, BOOKMARK_STR_SEPARATOR);
    bpCurrToken := StrToInt(BookmarkToken);
    BookmarkToken := StrTok(aBookmark, BOOKMARK_STR_SEPARATOR);
    BufferPosition := StrToInt(BookmarkToken);
    BookmarkToken := StrTok(aBookmark, BOOKMARK_STR_SEPARATOR);
    ContextLen := StrToInt(BookmarkToken);
    BookmarkToken := StrTok(aBookmark, BOOKMARK_STR_SEPARATOR);
    CurrLine := StrToInt(BookmarkToken);
    BookmarkToken := StrTok(aBookmark, BOOKMARK_STR_SEPARATOR);
    NumEOLInComment := StrToInt(BookmarkToken);
    BookmarkToken := StrTok(aBookmark, BOOKMARK_STR_SEPARATOR);
    StartOfLine := StrToInt(BookmarkToken);
    BookmarkToken := StrTok(aBookmark, BOOKMARK_STR_SEPARATOR);
    CurrentSymbol.Line := StrToInt(BookmarkToken);
    BookmarkToken := StrTok(aBookmark, BOOKMARK_STR_SEPARATOR);
    CurrentSymbol.Col := StrToInt(BookmarkToken);
    BookmarkToken := StrTok(aBookmark, BOOKMARK_STR_SEPARATOR);
    CurrentSymbol.Len := StrToInt(BookmarkToken);
    BookmarkToken := StrTok(aBookmark, BOOKMARK_STR_SEPARATOR);
    CurrentSymbol.Pos := StrToInt(BookmarkToken);
    BookmarkToken := StrTok(aBookmark, BOOKMARK_STR_SEPARATOR);
    NextSymbol.Line := StrToInt(BookmarkToken);
    BookmarkToken := StrTok(aBookmark, BOOKMARK_STR_SEPARATOR);
    NextSymbol.Col := StrToInt(BookmarkToken);
    BookmarkToken := StrTok(aBookmark, BOOKMARK_STR_SEPARATOR);
    NextSymbol.Len := StrToInt(BookmarkToken);
    BookmarkToken := StrTok(aBookmark, BOOKMARK_STR_SEPARATOR);
    NextSymbol.Pos := StrToInt(BookmarkToken);
    CurrInputCh := AnsiChar(ExtractBookmarkChar(aBookmark));  // ToDo
    LastInputCh := AnsiChar(ExtractBookmarkChar(aBookmark));
  except
    on EConvertError do
      Raise ECocoBookmark.Create(INVALID_INTEGER);
    else
      Raise;
  end;
end; {GotoBookmark}

constructor TCocoRScanner.Create;
begin
  inherited;
  fSrcStream := TMemoryStream.Create;
  CurrentSymbol := TSymbolPosition.Create;
  NextSymbol := TSymbolPosition.Create;
end; {Create}

destructor TCocoRScanner.Destroy;
begin
  fSrcStream.Free;
  fSrcStream := NIL;
  CurrentSymbol.Free;
  CurrentSymbol := NIL;
  NextSymbol.Free;
  NextSymbol := NIL;
  inherited;
end; {Destroy}

function TCocoRScanner.CapChAt(pos : longint) : AnsiChar;
begin
  Result := UpCase(CharAt(pos));
end; {CapCharAt}

function TCocoRScanner.CharAt(pos : longint) : AnsiChar;
var
  ch : AnsiChar;
begin
  if pos >= SourceLen then
  begin
    Result := _EF;
    exit;
  end;
  SrcStream.Seek(pos, soFromBeginning);
  SrcStream.ReadBuffer(Ch, 1);
  if ch <> _EOF then
    Result := ch
  else
    Result := _EF
end; {CharAt}

function TCocoRScanner.GetNStr(Symbol : TSymbolPosition; ChProc : TGetCh) : AnsiString;
var
  i : integer;
  p : longint;
begin
  SetLength(Result, Symbol.Len);
  p := Symbol.Pos;
  i := 1;
  while i <= Symbol.Len do
  begin
    Result[i] := ChProc(p);
    inc(i);
    inc(p)
  end;
end; {GetNStr}

function TCocoRScanner.GetName(Symbol : TSymbolPosition) : AnsiString;
begin
  Result := GetNStr(Symbol, CurrentCh);
end; {GetName}

function TCocoRScanner.GetStartState : PStartTable;
begin
  Result := @fStartState;
end; {GetStartState}

procedure TCocoRScanner.SetStartState(aStartTable : PStartTable);
begin
  fStartState := aStartTable^;
end; {SetStartState}

function TCocoRScanner.GetString(Symbol : TSymbolPosition) : AnsiString;
begin
  Result := GetNStr(Symbol, CharAt);
end; {GetString}

procedure TCocoRScanner._Reset;
var
  len : longint;
begin
  { Make sure that the stream has the _EF character at the end. }
  CurrInputCh := _EF;
  SrcStream.Seek(0, soFromEnd);
  SrcStream.WriteBuffer(CurrInputCh, 1);
  SrcStream.Seek(0, soFromBeginning);

  LastInputCh := _EF;
  len := SrcStream.Size;
  SourceLen := len;
  CurrLine := 1;
  StartOfLine := -2;
  BufferPosition := -1;
  CurrentSymbol.Clear;
  NextSymbol.Clear;
  NumEOLInComment := 0;
  ContextLen := 0;
  NextCh;
end; {_Reset}

{ TCocoRGrammar }

procedure TCocoRGrammar.ClearErrors;
var
  i : integer;
begin
  for i := 0 to fErrorList.Count - 1 do
    TCocoError(fErrorList[i]).Free;
  fErrorList.Clear;
end; {ClearErrors}

constructor TCocoRGrammar.Create(AOwner : TComponent);
begin
  inherited;
  FGenListWhen := glOnError;
  fClearSourceStream := true;
  fListStream := TMemoryStream.Create;
  fErrorList := TList.Create;
end; {Create}

destructor TCocoRGrammar.Destroy;
begin
  fListStream.Clear;
  fListStream.Free;
  ClearErrors;
  fErrorList.Free;
  inherited;
end; {Destroy}

procedure TCocoRGrammar.Expect(n : integer);
begin
  if CurrentInputSymbol = n then
    Get
  else
    SynError(n);
end; {Expect}

procedure TCocoRGrammar.GenerateListing;
  { Generate a source listing with error messages }
var
  i : integer;
  eof : boolean;
  lnr, errC : integer;
  srcPos : longint;
  line : AnsiString;
  PrintErrorCount : boolean;
begin
  if Assigned(BeforeGenList) then
    BeforeGenList(Self);
  srcPos := 0;
  GetLine(srcPos, line, eof);
  lnr := 1;
  errC := 0;
  while not eof do
  begin
    _StreamLine(PadL(IntToStr(lnr), ' ', 5) + '  ' + line);
    for i := 0 to ErrorList.Count - 1 do
    begin
      if TCocoError(ErrorList[i]).Line = lnr then
      begin
        PrintErr(line, TCocoError(ErrorList[i]).ErrorCode,
          TCocoError(ErrorList[i]).Col,
          TCocoError(ErrorList[i]).Data);
        inc(errC);
      end;
    end;
    GetLine(srcPos, line, eof);
    inc(lnr);
  end;
  // Now take care of the last line.
  for i := 0 to ErrorList.Count - 1 do
  begin
    if TCocoError(ErrorList[i]).Line = lnr then
    begin
      PrintErr(line, TCocoError(ErrorList[i]).ErrorCode,
        TCocoError(ErrorList[i]).Col,
        TCocoError(ErrorList[i]).Data);
      inc(errC);
    end;
  end;
  PrintErrorCount := true;
  if Assigned(AfterGenList) then
    AfterGenList(Self, PrintErrorCount);
  if PrintErrorCount then
  begin
    _StreamLine('');
    _StreamLn(PadL(IntToStr(errC), ' ', 5) + ' error');
    if errC <> 1 then
      _StreamLine('s');
  end;
end; {GenerateListing}

procedure TCocoRGrammar.GetLine(var pos : longint;
  var line : AnsiString;
  var eof : boolean);
  { Read a source line. Return empty line if eof }
var
  ch : AnsiChar;
  i : integer;
begin
  i := 1;
  eof := false;
  ch := Scanner.CharAt(pos);
  inc(pos);
  while not (ch in LineEnds) do
  begin
    SetLength(line, length(Line) + 1);
    line[i] := ch;
    inc(i);
    ch := Scanner.CharAt(pos);
    inc(pos);
  end;
  SetLength(line, i - 1);
  eof := (i = 1) and (ch = _EF);
  if ch = _CR then
  begin { check for MsDos end of lines }
    ch := Scanner.CharAt(pos);
    if ch = _LF then
    begin
      inc(pos);
      Extra := 0;
    end;
  end;
end; {GetLine}

function TCocoRGrammar.GetSourceStream : TMemoryStream;
begin
  Result := Scanner.SrcStream;
end; {GetSourceStream}

function TCocoRGrammar.GetSuccessful : boolean;
begin
  Result := ErrorList.Count = 0;
end; {GetSuccessful}

function TCocoRGrammar.LexName : AnsiString;
begin
  Result := Scanner.GetName(Scanner.CurrentSymbol)
end; {LexName}

function TCocoRGrammar.LexString : AnsiString;
begin
  Result := Scanner.GetString(Scanner.CurrentSymbol)
end; {LexString}

function TCocoRGrammar.LookAheadName : AnsiString;
begin
  Result := Scanner.GetName(Scanner.NextSymbol)
end; {LookAheadName}

function TCocoRGrammar.LookAheadString : AnsiString;
begin
  Result := Scanner.GetString(Scanner.NextSymbol)
end; {LookAheadString}

procedure TCocoRGrammar.PrintErr(line : AnsiString; ErrorCode : integer; col : integer; Data : AnsiString);
  { Print an error message }

  procedure DrawErrorPointer;
  var
    i : integer;
  begin
    _StreamLn('*****  ');
    i := 0;
    while i < col + Extra - 2 do
    begin
      if ((length(Line) > 0) and (length(Line) < i)) and (line[i] = _TAB) then
        _StreamLn(_TAB)
      else
        _StreamLn(' ');
      inc(i)
    end;
    _StreamLn('^ ')
  end; {DrawErrorPointer}

begin {PrintErr}
  DrawErrorPointer;
  _StreamLn(ErrorStr(ErrorCode, Data));
  _StreamLine('')
end; {PrintErr}

procedure TCocoRGrammar.SemError(const errNo : integer; const Data : AnsiString);
begin
  if errDist >= minErrDist then
    Scanner.ScannerError(errNo, Scanner.CurrentSymbol, Data, etSymantic);
  errDist := 0;
end; {SemError}

procedure TCocoRGrammar._StreamLn(s : AnsiString);
begin
  if length(s) > 0 then
    ListStream.WriteBuffer(s[1], length(s));
end; {_StreamLn}

procedure TCocoRGrammar._StreamLine(s : AnsiString);
begin
  s := s + chEOL;
  _StreamLn(s);
end; {_StreamLine}

procedure TCocoRGrammar.SynError(const errNo : integer);
begin
  if errDist >= minErrDist then
    Scanner.ScannerError(errNo, Scanner.NextSymbol, '', etSyntax);
  errDist := 0;
end; {SynError}

procedure TCocoRGrammar.SetOnStatusUpdate(const Value : TStatusUpdateProc);
begin
  FOnStatusUpdate := Value;
  Scanner.OnStatusUpdate := Value;
end; {SetOnStatusUpdate}

procedure TCocoRGrammar.SetSourceStream(const Value : TMemoryStream);
begin
  Scanner.SrcStream := Value;
end; {SetSourceStream}

procedure TCocoRGrammar.StoreError(nr : integer; Symbol : TSymbolPosition;
  Data : AnsiString; ErrorType : integer);
  { Store an error message for later printing }
var
  Error : TCocoError;
begin
  Error := TCocoError.Create;
  Error.ErrorCode := nr;
  if Assigned(Symbol) then
  begin
    Error.Line := Symbol.Line;
    Error.Col := Symbol.Col;
  end
  else
  begin
    Error.Line := 0;
    Error.Col := 0;
  end;
  Error.Data := Data;
  Error.ErrorType := ErrorType;
  ErrorList.Add(Error);
  if Assigned(OnError) then
    OnError(self, Error);
end; {StoreError}

function TCocoRGrammar.GetLineCount: integer;
begin
  Result := Scanner.CurrLine;
end; {GetLineCount}

function TCocoRGrammar.GetCharacterCount: integer;
begin
  Result := Scanner.BufferPosition;
end; {GetCharacterCount}

procedure TCocoRGrammar.DoBeforeParse;
begin
  if Assigned(fBeforeParse) then
    fBeforeParse(Self);
  if Assigned(fOnStatusUpdate) then
    fOnStatusUpdate(Self, cstBeginParse, '', -1);
end; {DoBeforeParse}

procedure TCocoRGrammar.DoAfterParse;
begin
  if Assigned(fOnStatusUpdate) then
    fOnStatusUpdate(Self, cstEndParse, '', -1);
  if Assigned(fAfterParse) then
    fAfterParse(Self);
end; {DoAfterParse}

function TCocoRGrammar.Bookmark: AnsiString;
begin
  Result :=
        IntToStr(fCurrentInputSymbol) + BOOKMARK_STR_SEPARATOR
      + Scanner.Bookmark;
end; {Bookmark}

procedure TCocoRGrammar.GotoBookmark(aBookmark: AnsiString);
var
  BookmarkToken : AnsiString;
begin
  try
    BookmarkToken := StrTok(aBookmark, BOOKMARK_STR_SEPARATOR);
    fCurrentInputSymbol := StrToInt(BookmarkToken);
    Scanner.GotoBookmark(aBookmark);
  except
    on EConvertError do
      Raise ECocoBookmark.Create(INVALID_INTEGER);
    else
      Raise;
  end;
end; {GotoBookmark}

{ TCommentList }

procedure TCommentList.Add(const S : AnsiString; const aLine : integer;
    const aColumn : integer);
var
  CommentItem : TCommentItem;
begin
  CommentItem := TCommentItem.Create;
  try
    CommentItem.Comment := FixComment(S);
    CommentItem.Line := aLine;
    CommentItem.Column := aColumn;
    fList.Add(CommentItem);
  except
    CommentItem.Free;
  end;
end; {Add}

procedure TCommentList.Clear;
var
  i : integer;
begin
  for i := 0 to fList.Count - 1 do
    TCommentItem(fList[i]).Free;
  fList.Clear;
end; {Clear}

constructor TCommentList.Create;
begin
  fList := TList.Create;
end; {Create}

destructor TCommentList.Destroy;
begin
  Clear;
  if Assigned(fList) then
  begin
    fList.Free;
    fList := NIL;
  end;
  inherited;
end; {Destroy}

function TCommentList.FixComment(const S: AnsiString): AnsiString;
begin
  Result := S;
  while (length(Result) > 0) AND (Result[length(Result)] < #32) do
    Delete(Result,Length(Result),1);
end; {FixComment}

function TCommentList.GetColumn(Idx: integer): integer;
begin
  Result := TCommentItem(fList[Idx]).Column;
end; {GetColumn}

function TCommentList.GetComments(Idx: integer): AnsiString;
begin
  Result := TCommentItem(fList[Idx]).Comment;
end; {GetComments}

function TCommentList.GetCount: integer;
begin
  Result := fList.Count;
end; {GetCount}

function TCommentList.GetLine(Idx: integer): integer;
begin
  Result := TCommentItem(fList[Idx]).Line;
end; {GetLine}

function TCommentList.GetText: AnsiString;
var
  i : integer;
begin
  Result := '';
  for i := 0 to Count - 1 do
  begin
    Result := Result + Comments[i];
    if i < Count - 1 then
      Result := Result + chEOL;
  end;
end; {GetText}

procedure TCommentList.SetColumn(Idx: integer; const Value: integer);
begin
  TCommentItem(fList[Idx]).Column := Value;
end; {SetColumn}

procedure TCommentList.SetComments(Idx: integer; const Value: AnsiString);
begin
  TCommentItem(fList[Idx]).Comment := Value;
end; {SetComments}

procedure TCommentList.SetLine(Idx: integer; const Value: integer);
begin
  TCommentItem(fList[Idx]).Line := Value;
end; {SetLine}

end.


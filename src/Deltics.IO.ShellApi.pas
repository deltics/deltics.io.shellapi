
{$i deltics.io.shellapi.inc}

  unit Deltics.IO.ShellApi;


interface

  type
    ShellApi = class
    public
      class procedure CopyFile(const aFilename: String; const aDestPath: String);
    end;


implementation

  uses
    ShellApi,
    SysUtils,
    Deltics.IO.Path;


  class procedure ShellApi.CopyFile(const aFilename: String; const aDestPath: String);
  var
    fileOp: TSHFileOpStruct;
    srcFile: String;
    srcFileDnt: String;
    destFile: String;
    destFileDnt: String;
    copyResult: Integer;
  begin
    srcFile   := aFilename;
    destFile  := Path.Append(aDestPath, ExtractFilename(aFilename));

    // Shell Api operation filenames must be DOUBLE null-terminated!

    srcFileDnt  := srcFile + #0;
    destFileDnt := destFile + #0;

    fileOp.Wnd    := 0;
    fileOp.wFunc  := FO_COPY;
    fileOp.pFrom  := PChar(srcFileDnt);
    fileOp.pTo    := PChar(destFileDnt);
    fileOp.fFlags := FOF_SILENT;
    fileOp.lpszProgressTitle  := NIL;

    copyResult := ShFileOperation(fileOp);
    if copyResult <> 0 then
      raise EInOutError.Create(SysErrorMessage(copyResult));
  end;


end.

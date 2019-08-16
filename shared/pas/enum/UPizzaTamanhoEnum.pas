unit UPizzaTamanhoEnum;

interface

type
  TPizzaTamanhoEnum = (enPequena, enMedia, enGrande);

  function TamanhoToText(ATamanho: TPizzaTamanhoEnum): String;
  function TextToTamanho(ATamanho: String): TPizzaTamanhoEnum;
implementation

uses
  System.SysUtils, System.StrUtils;
function TamanhoToText(ATamanho: TPizzaTamanhoEnum): String;
begin
    case ATamanho of
      enPequena : Result := 'enPequena';

      enMedia : Result := 'enMedia';
      enGrande : Result := 'enGrande';
      else
      raise Exception.Create('Tamanho não encontrado.');
    end;

  end;

function TextToTamanho(ATamanho: String): TPizzaTamanhoEnum;
begin
    case AnsiIndexStr(ATamanho, ['enPequena', 'enMedia', 'enGrande']) of
      0 : Result := enPequena;
      1 : Result := enMedia;
      2 : Result := enGrande;
      else
      raise Exception.Create('Tamanho não encontrado.');
    end;

  end;

end.

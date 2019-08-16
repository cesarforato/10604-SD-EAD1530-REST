unit UPizzaSaborEnum;

interface

type
  TPizzaSaborEnum = (enCalabresa, enMarguerita, enPortuguesa);

  function SaborToText(ASabor: TPizzaSaborEnum): String;
  function TextToSabor(ASabor: String): TPizzaSaborEnum;

implementation

uses
  System.SysUtils, System.StrUtils;
function SaborToText(ASabor: TPizzaSaborEnum): String;
begin
    case ASabor of
      enCalabresa : Result := 'enCalabresa';

      enMarguerita : Result := 'enMarguerita';
      enPortuguesa : Result := 'enPortuguesa';
      else
      raise Exception.Create('Sabor não encontrado.');
    end;

  end;

function TextToSabor(ASabor: String): TPizzaSaborEnum;
begin
    case AnsiIndexStr(ASabor, ['enCalabresa', 'enMarguerita', 'enPortuguesa']) of
      0 : Result := enCalabresa;
      1: Result := enMarguerita;
      2 : Result := enPortuguesa;
      else
      raise Exception.Create('Sabor não encontrado.');
    end;

  end;
end.

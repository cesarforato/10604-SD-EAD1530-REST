unit UPedidoRepositoryImpl;

interface

uses
  UPedidoRepositoryIntf, UPizzaTamanhoEnum, UPizzaSaborEnum, UDBConnectionIntf, FireDAC.Comp.Client;

type
  TPedidoRepository = class(TInterfacedObject, IPedidoRepository)
  private
    FDBConnection: IDBConnection;
    FFDQuery: TFDQuery;
  public
    procedure efetuarPedido(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum; const AValorPedido: Currency;
      const ATempoPreparo: Integer; const ACodigoCliente: Integer);

    procedure consultarPedido(const ADocumentoCliente: string;
      out AFDQuery: TFDQuery);

    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation

uses
  UDBConnectionImpl, System.SysUtils, Data.DB, FireDAC.Stan.Param;

const
  CMD_INSERT_PEDIDO
    : String =
    'INSERT INTO tb_pedido (cd_cliente, dt_pedido, dt_entrega, vl_pedido, nr_tempopedido, tx_tamanhopizza, tx_saborpizza) '+
    ' VALUES (:pCodigoCliente, :pDataPedido, :pDataEntrega, :pValorPedido, :pTempoPedido, :pTamanhoPizza, :pSaborPizza)';
  CM_CONSULTAR_PEDIDO
    : String =
    'SELECT tx_tamanhopizza, tx_saborpizza, vl_pedido, nr_tempopedido ' +
    ' FROM tb_pedido t1 INNER JOIN tb_cliente t2 on(t1.cd_cliente = t2.id) ' +
    ' WHERE t2.nr_documento = :pDocumentoCliente ORDER BY t1.id DESC LIMIT 1';
  { TPedidoRepository }

procedure TPedidoRepository.consultarPedido(const ADocumentoCliente: string;
  out AFDQuery: TFDQuery);
begin
  AFDQuery.Connection := FDBConnection.getDefaultConnection;
  AFDQuery.SQL.Text := CM_CONSULTAR_PEDIDO;

  AFDQuery.ParamByName('pDocumentoCliente').AsString := ADocumentoCliente;
  AFDQuery.Prepare;
  AFDQuery.Open();
end;

constructor TPedidoRepository.Create;
begin
  inherited;

  FDBConnection := TDBConnection.Create;
  FFDQuery := TFDQuery.Create(nil);
  FFDQuery.Connection := FDBConnection.getDefaultConnection;
end;

destructor TPedidoRepository.Destroy;
begin
  FFDQuery.Free;
  inherited;
end;

procedure TPedidoRepository.efetuarPedido(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum; const AValorPedido: Currency;
  const ATempoPreparo: Integer; const ACodigoCliente: Integer);
begin
  FFDQuery.SQL.Text := CMD_INSERT_PEDIDO;

  FFDQuery.ParamByName('pCodigoCliente').AsInteger := ACodigoCliente;
  FFDQuery.ParamByName('pDataPedido').AsDateTime := now();
  FFDQuery.ParamByName('pDataEntrega').AsDateTime := now();
  FFDQuery.ParamByName('pValorPedido').AsCurrency := AValorPedido;
  FFDQuery.ParamByName('pTempoPedido').AsInteger := ATempoPreparo;
  FFDQuery.ParamByName('pTamanhoPizza').Value := TamanhoToText(APizzaTamanho);
  FFDQuery.ParamByName('pSaborPizza').Value := SaborToText(APizzaSabor);

  FFDQuery.Prepare;
  FFDQuery.ExecSQL(True);
end;

end.

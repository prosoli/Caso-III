--Permitir que payment ID sea nulo pues no necesariamnete una transaccion está relacionada a un payment
--y hacer que sea big int para hacer match con la tabla payments

--Eliminar la restricción de clave externa temporalmente
IF EXISTS (SELECT 1 
           FROM sys.foreign_keys 
           WHERE name = 'FK_vpv_transactions_vpv_payments')
BEGIN
    ALTER TABLE [dbo].[vpv_transactions]
    DROP CONSTRAINT FK_vpv_transactions_vpv_payments;
END

--Modificar la columna paymentId para permitir valores nulos
ALTER TABLE [dbo].[vpv_transactions]
ALTER COLUMN [paymentId] BIGINT NULL;

--Volver a agregar la restricción de clave externa
ALTER TABLE [dbo].[vpv_transactions]
ADD CONSTRAINT FK_vpv_transactions_vpv_payments FOREIGN KEY ([paymentId])
REFERENCES [dbo].[vpv_payments] ([paymentId]);



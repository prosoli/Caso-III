--Más seeding para el funcionamiento del SP de repartir dividendos 

-------------------------
--INVESTOR PER PROJECT
-------------------------

INSERT INTO [dbo].[vpv_investorsPerProject]
           ([idUser],[entitydid],[crowdfoundingProposalId],[enable],[sponsorAgreementId])
     VALUES
	 --Participan unicamente usuarios como inversionistas
           (1,NULL,1,1,1),	-- Inversionistas para CF Prop 1
		   (2,NULL,1,1,2),
		   (3,NULL,1,1,3),
		   (4,NULL,1,1,4),

           (5,NULL,2,1,5),	-- Inversionistas para CF Prop 2
		   (3,NULL,2,1,6),
		   (6,NULL,2,1,7),
		   (7,NULL,2,1,8),
		   (1,NULL,2,1,9),

           (7,NULL,3,1,10),	-- Inversionistas para CF Prop 3
		   (8,NULL,3,1,11),
		   (2,NULL,3,1,12),
		   (5,NULL,3,1,13);


--------------------------------------
--Available Payment Methods Per User
--------------------------------------
--NOTA: Ejecute el proc vpvSP_InsertarPaymentMethods para el funcionamiento del insert
INSERT INTO [dbo].[vpv_availablePaymentMethodsPerUser]
           ([enable],[paymentMethodId],[idUser])
     VALUES
           (1,1,1),
		   (1,2,2),
		   (1,1,3),
		   (1,2,4),
           (1,1,5),
		   (1,2,6),
		   (1,1,8);
--El user 7 queda sin regisro para generar error en el SP


-----------------------
--DOCS PARA PROJECT TRACKINGS
-----------------------

INSERT INTO [dbo].[vpv_docs]
           ([identitydocsid],[formatid],[docstypeid],[docstateid],[archive],[filename],[date],[enable]
           ,[startdate],[nextcheckdate],[semantic_category],[checksum])
     VALUES
		(1, 1, 3, 3, 0x25504446, 'reporte de fiscalización 1.pdf', GETDATE(), 1, GETDATE(), '2025-12-20', 'reporte de fiscalización de la propuesta 1 ', CHECKSUM('Dato de prueba')),
		(2, 1, 3, 3, 0x25504446, 'reporte fiscalización 2.pdf', GETDATE(), 1, GETDATE(), '2025-12-20', 'reporte de fiscalización de la propuesta 1', CHECKSUM('Dato de prueba')),
		(3, 1, 3, 3, 0xFFD8FFE0, 'reporte fiscalización 3.jpg', GETDATE(), 1, GETDATE(), '2025-12-20', 'reporte de fiscalización de la propuesta 1', CHECKSUM('Dato de prueba'));


----------------------
-- PROJECT TRACKING
----------------------

INSERT INTO [dbo].[vpv_ProposalTracking]
           ([userId],[proposalId],[creationDate],[enable],[deleted],[statusId],[docid],[tittle],[scheduleId],[description])
     VALUES
           (1, 1, GETDATE(), 1, 0, 5, 4, 'Fiscalización de propuesta', 1, NULL),
           (2, 2, GETDATE(), 1, 0, 5, 5, 'Fiscalización de propuesta', 1, NULL),
           (3, 3, GETDATE(), 1, 0, 5, 6, 'Fiscalización de propuesta', 1, NULL);


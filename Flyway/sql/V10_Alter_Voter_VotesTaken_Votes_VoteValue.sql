USE [puravidabd];
GO

-- 1) Quitar FKs que apuntan a vpv_Voter
ALTER TABLE dbo.vpv_VoterDemographics    DROP CONSTRAINT FK_vpv_VoterDemographics_vpv_Voter;
ALTER TABLE dbo.vpv_Voter                DROP CONSTRAINT FK_vpv_Voter_vpv_Users;
ALTER TABLE dbo.vpv_Votes                DROP CONSTRAINT FK_vpv_Votes_vpv_Voter;
ALTER TABLE dbo.vpv_VoterResidence       DROP CONSTRAINT FK_vpv_VoterResidence_vpv_Voter;
GO

-- 2) Volcar datos a tabla temporal
SELECT *
INTO dbo.__tmp_vpv_Voter
FROM dbo.vpv_Voter;
GO

-- 3) Eliminar la tabla original
DROP TABLE dbo.vpv_Voter;
GO

-- 4) Crear tabla con IDENTITY en idVoter
CREATE TABLE dbo.vpv_Voter (
    idVoter   INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    age       INT             NOT NULL,
    idUser    INT             NULL,
    checksum  VARBINARY(MAX)  NOT NULL
);
GO

-- 5) Transferir datos preservando idVoter original
SET IDENTITY_INSERT dbo.vpv_Voter ON;
INSERT INTO dbo.vpv_Voter (idVoter, age, idUser, checksum)
SELECT idVoter, age, idUser, checksum
FROM dbo.__tmp_vpv_Voter
ORDER BY idVoter;
SET IDENTITY_INSERT dbo.vpv_Voter OFF;
GO

-- 6) Limpiar temporal
DROP TABLE dbo.__tmp_vpv_Voter;
GO

-- 7) Recrear FKs
ALTER TABLE dbo.vpv_VoterDemographics
  ADD CONSTRAINT FK_vpv_VoterDemographics_vpv_Voter
    FOREIGN KEY (idVoter) REFERENCES dbo.vpv_Voter(idVoter);

ALTER TABLE dbo.vpv_Voter
  ADD CONSTRAINT FK_vpv_Voter_vpv_Users
    FOREIGN KEY (idUser) REFERENCES dbo.vpv_Users(idUser);

ALTER TABLE dbo.vpv_Votes
  ADD CONSTRAINT FK_vpv_Votes_vpv_Voter
    FOREIGN KEY (idVoter) REFERENCES dbo.vpv_Voter(idVoter);

ALTER TABLE dbo.vpv_VoterResidence
  ADD CONSTRAINT FK_vpv_VoterResidence_vpv_Voter
    FOREIGN KEY (idVoter) REFERENCES dbo.vpv_Voter(idVoter);
GO

PRINT 'Reconstrucción de vpv_Voter con IDENTITY completada.';
GO











USE [puravidabd];
GO

-- 1) Quitar default constraint y FKs que apuntan a vpv_Votes
ALTER TABLE dbo.vpv_Votes              DROP CONSTRAINT DF_vpv_Votes_creationDate;
ALTER TABLE dbo.vpv_VoteComment        DROP CONSTRAINT FK_vpv_VoteComment_vpv_Votes;
ALTER TABLE dbo.vpv_Votes              DROP CONSTRAINT FK_vpv_Votes_vpv_Voter;
ALTER TABLE dbo.vpv_Votes              DROP CONSTRAINT FK_vpv_Votes_vpv_BlindTokens;
ALTER TABLE dbo.vpv_Votes              DROP CONSTRAINT FK_vpv_Votes_vpv_optionsQuestion;
ALTER TABLE dbo.vpv_Votes              DROP CONSTRAINT FK_vpv_Votes_vpv_votingQuestions;
ALTER TABLE dbo.vpv_voteValues         DROP CONSTRAINT FK_vpv_voteValues_vpv_Votes;
GO

-- 2) Volcar datos a tabla temporal
SELECT *
INTO dbo.__tmp_vpv_Votes
FROM dbo.vpv_Votes;
GO

-- 3) Eliminar la tabla original
DROP TABLE dbo.vpv_Votes;
GO

-- 4) Crear vpv_Votes con IDENTITY y default
CREATE TABLE dbo.vpv_Votes (
    idVote           INT              IDENTITY(1,1) NOT NULL PRIMARY KEY,
    idVotingQuestion INT              NOT NULL,
    creationDate     DATETIME         NOT NULL
                       CONSTRAINT DF_vpv_Votes_creationDate DEFAULT (GETDATE()),
    idToken          UNIQUEIDENTIFIER NOT NULL,
    idVoter          INT              NOT NULL,
    idOptionQuestion INT              NOT NULL,
    checksum         VARBINARY(MAX)   NOT NULL
);
GO

-- 5) Transferir los datos antiguos preservando idVote
SET IDENTITY_INSERT dbo.vpv_Votes ON;
INSERT INTO dbo.vpv_Votes
    (idVote, idVotingQuestion, creationDate, idToken, idVoter, idOptionQuestion, checksum)
SELECT
    idVote, idVotingQuestion, creationDate, idToken, idVoter, idOptionQuestion, checksum
FROM dbo.__tmp_vpv_Votes
ORDER BY idVote;
SET IDENTITY_INSERT dbo.vpv_Votes OFF;
GO

-- 6) Limpiar tabla temporal
DROP TABLE dbo.__tmp_vpv_Votes;
GO

-- 7) Recrear FKs
ALTER TABLE dbo.vpv_VoteComment
  ADD CONSTRAINT FK_vpv_VoteComment_vpv_Votes
    FOREIGN KEY (idVote) REFERENCES dbo.vpv_Votes(idVote);

ALTER TABLE dbo.vpv_Votes
  ADD CONSTRAINT FK_vpv_Votes_vpv_Voter
    FOREIGN KEY (idVoter) REFERENCES dbo.vpv_Voter(idVoter);

ALTER TABLE dbo.vpv_Votes
  ADD CONSTRAINT FK_vpv_Votes_vpv_BlindTokens
    FOREIGN KEY (idToken) REFERENCES dbo.vpv_BlindTokens(idToken);

ALTER TABLE dbo.vpv_Votes
  ADD CONSTRAINT FK_vpv_Votes_vpv_optionsQuestion
    FOREIGN KEY (idOptionQuestion) REFERENCES dbo.vpv_optionsQuestion(idOptionQuestion);

ALTER TABLE dbo.vpv_Votes
  ADD CONSTRAINT FK_vpv_Votes_vpv_votingQuestions
    FOREIGN KEY (idVotingQuestion) REFERENCES dbo.vpv_votingQuestions(idVotingQuestions);

ALTER TABLE dbo.vpv_voteValues
  ADD CONSTRAINT FK_vpv_voteValues_vpv_Votes
    FOREIGN KEY (idVote) REFERENCES dbo.vpv_Votes(idVote);
GO

PRINT 'Reconstrucción de vpv_Votes con IDENTITY y default completada.';
GO









USE [puravidabd];
GO

-- 1) Quitar default constraint y FKs que apuntan a vpv_VotesTaken
ALTER TABLE dbo.vpv_VotesTaken DROP CONSTRAINT DF_vpv_VotesTaken_creacionDate;
ALTER TABLE dbo.vpv_VotesTaken DROP CONSTRAINT FK_vpv_VotesTaken_vpv_votingQuestions;
ALTER TABLE dbo.vpv_VotesTaken DROP CONSTRAINT FK_vpv_VotesTaken_vpv_Users;
GO

-- 2) Volcar datos a tabla temporal
SELECT *
INTO dbo.__tmp_vpv_VotesTaken
FROM dbo.vpv_VotesTaken;
GO

-- 3) Eliminar la tabla original
DROP TABLE dbo.vpv_VotesTaken;
GO

-- 4) Crear vpv_VotesTaken con IDENTITY y default
CREATE TABLE dbo.vpv_VotesTaken (
    idVoteTaken       INT             IDENTITY(1,1) NOT NULL PRIMARY KEY,
    idUser            INT             NOT NULL,
    idVotingQuestions INT             NOT NULL,
    creacionDate      DATETIME        NOT NULL
                         CONSTRAINT DF_vpv_VotesTaken_creacionDate DEFAULT (GETDATE()),
    checksum          VARBINARY(MAX)  NOT NULL
);
GO

-- 5) Transferir los datos antiguos preservando idVoteTaken
SET IDENTITY_INSERT dbo.vpv_VotesTaken ON;
INSERT INTO dbo.vpv_VotesTaken
    (idVoteTaken, idUser, idVotingQuestions, creacionDate, checksum)
SELECT
    idVoteTaken, idUser, idVotingQuestions, creacionDate, checksum
FROM dbo.__tmp_vpv_VotesTaken
ORDER BY idVoteTaken;
SET IDENTITY_INSERT dbo.vpv_VotesTaken OFF;
GO

-- 6) Limpiar tabla temporal
DROP TABLE dbo.__tmp_vpv_VotesTaken;
GO

-- 7) Recrear las FKs
ALTER TABLE dbo.vpv_VotesTaken
  ADD CONSTRAINT FK_vpv_VotesTaken_vpv_votingQuestions
    FOREIGN KEY (idVotingQuestions) REFERENCES dbo.vpv_votingQuestions(idVotingQuestions);

ALTER TABLE dbo.vpv_VotesTaken
  ADD CONSTRAINT FK_vpv_VotesTaken_vpv_Users
    FOREIGN KEY (idUser) REFERENCES dbo.vpv_Users(idUser);
GO

PRINT 'Reconstrucción de vpv_VotesTaken con IDENTITY y default completada.';
GO








USE [puravidabd];
GO

-- 1) Quitar la FK que apunta a vpv_Votes
ALTER TABLE dbo.vpv_voteValues
  DROP CONSTRAINT FK_vpv_voteValues_vpv_Votes;
GO

-- 2) Volcar los datos a una tabla temporal
SELECT *
INTO dbo.__tmp_vpv_voteValues
FROM dbo.vpv_voteValues;
GO

-- 3) Eliminar la tabla original
DROP TABLE dbo.vpv_voteValues;
GO

-- 4) Crear vpv_voteValues con IDENTITY en idVoteValue
CREATE TABLE dbo.vpv_voteValues (
    idVoteValue INT             IDENTITY(1,1) NOT NULL PRIMARY KEY,
    value1      VARBINARY(100)  NOT NULL,
    value2      VARBINARY(100)  NOT NULL,
    idVote      INT             NOT NULL,
    checksum    VARBINARY(MAX)  NOT NULL
);
GO

-- 5) Transferir los datos preservando idVoteValue
SET IDENTITY_INSERT dbo.vpv_voteValues ON;
INSERT INTO dbo.vpv_voteValues (idVoteValue, value1, value2, idVote, checksum)
SELECT idVoteValue, value1, value2, idVote, checksum
FROM dbo.__tmp_vpv_voteValues
ORDER BY idVoteValue;
SET IDENTITY_INSERT dbo.vpv_voteValues OFF;
GO

-- 6) Limpiar la tabla temporal
DROP TABLE dbo.__tmp_vpv_voteValues;
GO

-- 7) Recrear la FK
ALTER TABLE dbo.vpv_voteValues
  ADD CONSTRAINT FK_vpv_voteValues_vpv_Votes
    FOREIGN KEY (idVote) REFERENCES dbo.vpv_Votes(idVote);
GO

PRINT 'Reconstrucción de vpv_voteValues con IDENTITY completada.';
GO

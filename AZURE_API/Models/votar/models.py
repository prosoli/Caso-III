from sqlalchemy import (Column, Integer, String, Boolean, DateTime, ForeignKey, Unicode, LargeBinary, DECIMAL, VARBINARY, NVARCHAR, BigInteger, func)
from sqlalchemy.dialects.mssql import UNIQUEIDENTIFIER
from sqlalchemy.orm import relationship, declarative_base

import uuid


Base = declarative_base()

class User(Base):
    __tablename__ = "vpv_Users"
    idUser            = Column("idUser", Integer, primary_key=True)
    nationalityid     = Column("nationalityid", Integer, nullable=False)
    sexid             = Column("sexid", Integer, nullable=False)
    # id_card           = Column("id_card", NVARCHAR(50), nullable=False)
    # name              = Column("name", NVARCHAR(50), nullable=False)
    # lastname          = Column("lastname", NVARCHAR(50), nullable=False)
    birth             = Column("birth", DateTime, nullable=False)
    registration_date = Column("registration_date", DateTime, nullable=False)
    is_verified       = Column("is_verified", Boolean, nullable=True)
    enable            = Column("enable", Boolean, nullable=True)
    deleted           = Column("deleted", Boolean, nullable=True)

class UserRole(Base):
    __tablename__ = "vpv_UserRole"
    id_user_role = Column("id_user_role", Integer, primary_key=True)
    idUser       = Column("idUser", Integer, ForeignKey("vpv_Users.idUser"))
    id_role      = Column("id_role", Integer, ForeignKey("vpv_Roles.id_role"))
    creationDate = Column("creationDate", DateTime, nullable=False)
    updateAt     = Column("updateAt", DateTime, nullable=False)
    enabled      = Column("enabled", Boolean, nullable=False)
    deleted      = Column("deleted", Boolean, nullable=False)
    checksum     = Column("checksum", String)  # varbinary mapped to String safe

    role = relationship("Role", back_populates="user_roles")

class Role(Base):
    __tablename__ = "vpv_Roles"
    id_role      = Column("id_role", Integer, primary_key=True)
    name         = Column("name", String(100), nullable=False)
    descripcion  = Column("descripcion", String(255), nullable=False)
    creationDate = Column("creationDate", DateTime, nullable=False)
    updateAt     = Column("updateAt", DateTime, nullable=False)
    enabled      = Column("enabled", Boolean, nullable=False)
    deleted      = Column("deleted", Boolean, nullable=False)
    checksum     = Column("checksum", String)

    user_roles      = relationship("UserRole", back_populates="role")
    role_permissions = relationship("RolePermission", back_populates="role")

class PermissionResource(Base):
    __tablename__ = "vpv_PermissionResource"
    id_permissionResource = Column("id_permissionResource", Integer, primary_key=True)
    name                  = Column("name", String(200), nullable=False)
    creationDate          = Column("creationDate", DateTime, nullable=False)
    updatedAt             = Column("updatedAt", DateTime, nullable=False)
    enabled               = Column("enabled", Boolean, nullable=False)
    deleted               = Column("deleted", Boolean, nullable=False)

class PermissionAction(Base):
    __tablename__ = "vpv_PermissionAction"
    id_permissionAction = Column("id_permissionAction", Integer, primary_key=True)
    name                = Column("name", String(20), nullable=False)
    descripcion         = Column("descripcion", String(150), nullable=False)

class Permission(Base):
    __tablename__ = "vpv_Permissions"
    id_permission        = Column("id_permission", Integer, primary_key=True)
    id_permisionResource = Column("id_permisionResource", Integer, ForeignKey("vpv_PermissionResource.id_permissionResource"))
    id_permissionAction  = Column("id_permissionAction", Integer, ForeignKey("vpv_PermissionAction.id_permissionAction"))
    descripcion          = Column("descripcion", String(255), nullable=False)
    creationDate         = Column("creationDate", DateTime, nullable=False)
    updatedAt            = Column("updatedAt", DateTime, nullable=False)
    enabled              = Column("enabled", Boolean, nullable=False)
    deleted              = Column("deleted", Boolean, nullable=False)
    checksum             = Column("checksum", String)

    resource = relationship("PermissionResource")
    action   = relationship("PermissionAction")
    role_permissions = relationship("RolePermission", back_populates="permission")

class RolePermission(Base):
    __tablename__ = "vpv_RolePermission"
    id_role_permission = Column("id_role_permission", Integer, primary_key=True)
    id_role            = Column("id_role", Integer, ForeignKey("vpv_Roles.id_role"))
    id_permission      = Column("id_permission", Integer, ForeignKey("vpv_Permissions.id_permission"))

    role       = relationship("Role", back_populates="role_permissions")
    permission = relationship("Permission", back_populates="role_permissions")

    
# class VotingQuestion(Base):
#     __tablename__ = "vpv_votingQuestions"
#     idVotingQuestions = Column(Integer, primary_key=True)
#     idQuestionType    = Column(Integer, nullable=False)
#     description       = Column(String(1000), nullable=False)
#     idVotingConfig    = Column(Integer, ForeignKey("vpv_votingConfigurations.idVotingConfig"), nullable=False)
#     enable            = Column(Boolean, nullable=False)
#     creationDate      = Column(DateTime, nullable=False)
#     # checksum          = Column(String(100), nullable=False)
#     orderBy           = Column(Integer, nullable=False)

#     voting_config = relationship("VotingConfiguration", back_populates="questions")

class VotingQuestion(Base):
    __tablename__ = "vpv_votingQuestions"
    idVotingQuestions = Column(Integer, primary_key=True)
    idQuestion        = Column(Integer, ForeignKey("vpv_questions.idQuestion"), nullable=False)
    idVotingConfig    = Column(Integer, nullable=False)
    enable            = Column(Boolean, nullable=False)
    creationDate      = Column(DateTime, nullable=False)
    checksum          = Column(NVARCHAR(100), nullable=True)
    orderBy           = Column(Integer, nullable=False)

    # voting_config = relationship("VotingConfiguration", back_populates="questions")

    # question     = relationship("Question", back_populates="voting_links")

# class OptionQuestion(Base):
#     __tablename__ = "vpv_optionsQuestion"
#     idOptionQuestion   = Column(Integer, primary_key=True)
#     idOptionType       = Column(Integer, nullable=False)
#     idVotingQuestions  = Column(Integer, ForeignKey("vpv_votingQuestions.idVotingQuestions"), nullable=False)
#     value              = Column(String(500), nullable=False)
#     description        = Column(String(500), nullable=False)
#     # checksum           = Column(String(255), nullable=False)
#     creationDate       = Column(DateTime, nullable=False)
#     enable             = Column(Boolean, nullable=False)
#     orderby            = Column(Integer, nullable=False)

#     # question = relationship("VotingQuestion", back_populates="options")

class OptionQuestion(Base):
    __tablename__ = "vpv_optionsQuestion"
    idOptionQuestion  = Column(Integer, primary_key=True)
    idOptionType      = Column(Integer, nullable=False)
    idQuestions       = Column(Integer, ForeignKey("vpv_questions.idQuestion"), nullable=False) # vpv_votingQuestions.idVotingQuestions
    value             = Column(String(500), nullable=False)
    description       = Column(String(500), nullable=False)
    checksum          = Column(NVARCHAR(255), nullable=False)
    creationDate      = Column(DateTime, nullable=False)
    enable            = Column(Boolean, nullable=False)
    orderby           = Column(Integer, nullable=False)

class VotingConfiguration(Base):
    __tablename__ = "vpv_votingConfigurations"
    idVotingConfig        = Column(Integer, primary_key=True)
    proposalVersionId     = Column(Integer, nullable=True)
    openDate              = Column(DateTime, nullable=False)
    closeDate             = Column(DateTime, nullable=False)
    creationDate          = Column(DateTime, nullable=False)
    idStatusVoting        = Column(Integer, nullable=False)
    idVotingType          = Column(Integer, nullable=False)
    description           = Column(String(1000), nullable=False)
    weight                = Column(Boolean, nullable=False)
    # checksum              = Column(String(255), nullable=False)
    idReminderType        = Column(Integer, nullable=False)
    idClosureTypes        = Column(Integer, nullable=False)
    idvotingReasons       = Column(Integer, nullable=False)
    executionPlanId       = Column(Integer, nullable=True)
    metricPlanId          = Column(Integer, nullable=True)
    projectReportId       = Column(Integer, nullable=True)
    sponsorAgreementId    = Column(Integer, nullable=True)
    governmentConditionId = Column(Integer, nullable=True)

    # questions = relationship("VotingQuestion", back_populates="voting_config")
    target_populations = relationship("TargetPopulationsVoting", back_populates="voting_config")

class ProposalVersion(Base):
    __tablename__ = "vpv_proposalVersions"
    proposalVersionId = Column(Integer, primary_key=True)
    tittle            = Column(String(100), nullable=False)
    content           = Column(String(500), nullable=False)
    creationDate      = Column(DateTime, nullable=False)
    startingDate      = Column(DateTime, nullable=False)
    scheduleId        = Column(Integer, nullable=False)
    enable            = Column(Boolean, nullable=False)
    deleted           = Column(Boolean, nullable=False)
    checksum          = Column(VARBINARY(255), nullable=False)
    statusid          = Column(Integer, nullable=False)
    budget            = Column(DECIMAL(10,8), nullable=True)
    lastUpdate        = Column(DateTime, nullable=False)
    idUser            = Column(Integer, nullable=False)
    proposalId        = Column(Integer, ForeignKey("vpv_proposals.proposalId"), nullable=False)
    lastVersion       = Column(Boolean, nullable=False)

    proposal = relationship("Proposal", back_populates="versions")

class Proposal(Base):
    __tablename__ = "vpv_proposals"
    proposalId              = Column(Integer, primary_key=True)
    idUser                  = Column(Integer, nullable=False)
    entitydid               = Column(Integer, nullable=True)
    tittle                  = Column(String(100), nullable=False)
    description             = Column(String(500), nullable=False)
    creationDate            = Column(DateTime, nullable=False)
    scheduleId              = Column(Integer, nullable=False)
    enable                  = Column(Boolean, nullable=False)
    deleted                 = Column(Boolean, nullable=False)
    ckecksum                = Column(VARBINARY(255), nullable=False)
    statusId                = Column(Integer, nullable=False)
    budget                  = Column(DECIMAL(10,8), nullable=True)
    idTargetPopulation      = Column(Integer, nullable=False)
    proposalTypeId          = Column(Integer, nullable=False)
    lastUpdate              = Column(DateTime, nullable=False)
    startingDate            = Column(DateTime, nullable=False)
    proposalTypeId_semantica= Column(String(50), nullable=True)
    relacion                = Column(String(500), nullable=True)

    versions = relationship("ProposalVersion", back_populates="proposal")

class TargetPopulationsVoting(Base):
    __tablename__ = "vpv_TargetPopulationsVoting"
    idTargetPopulationsVoting = Column(Integer, primary_key=True)
    idVotingConfig            = Column(Integer, ForeignKey("vpv_votingConfigurations.idVotingConfig"), nullable=False)
    idTargetPopulation        = Column(Integer, ForeignKey("vpv_TargetPopulations.idTargetPopulation"), nullable=False)
    checksum                  = Column(String(255), nullable=False)
    enable                    = Column(Boolean, nullable=False)
    weight                    = Column(DECIMAL(5,2), nullable=True)

    voting_config     = relationship("VotingConfiguration", back_populates="target_populations")
    target_population = relationship("TargetPopulation", back_populates="voting_links")

class TargetPopulation(Base):
    __tablename__ = "vpv_TargetPopulations"
    idTargetPopulation = Column(Integer, primary_key=True)
    name               = Column(String(50), nullable=False)
    description        = Column(String(500), nullable=False)
    creationDate       = Column(DateTime, nullable=False)
    enable             = Column(Boolean, nullable=False)
    checksum           = Column(String(255), nullable=True)

    voting_links = relationship("TargetPopulationsVoting", back_populates="target_population")

class PopulationFilter(Base):
    __tablename__ = "vpv_PopulationFilters"
    idPopulationFilter = Column(Integer, primary_key=True)
    description        = Column(String(50), nullable=True)
    idFilterType       = Column(Integer, ForeignKey("vpv_FilterTypes.idFilterType"), nullable=False)
    valueMin           = Column(DECIMAL(5,2), nullable=True)
    valueMax           = Column(DECIMAL(5,2), nullable=True)
    referenceValue     = Column(Integer, nullable=True)
    validation         = Column(Boolean, nullable=True)
    enable             = Column(Boolean, nullable=False)
    creationDate       = Column(DateTime, nullable=False)
    # checksum           = Column(String(255), nullable=False)
    idTargetPopulation = Column(Integer, ForeignKey("vpv_TargetPopulations.idTargetPopulation"), nullable=False)

    filter_type       = relationship("FilterType")
    target_population = relationship("TargetPopulation")

class FilterType(Base):
    __tablename__ = "vpv_FilterTypes"
    idFilterType = Column(Integer, primary_key=True)
    name         = Column(String(30), nullable=False)
    enable       = Column(Boolean, nullable=False)
    datatype     = Column(String(30), nullable=False)
    referenceId  = Column(String(30), nullable=True)
    reference    = Column(Boolean, nullable=False)
    demotypeid   = Column(Integer, ForeignKey("vpv_demotype.demotypeid"), nullable=True)
    demosubtypeid= Column(Integer, ForeignKey("vpv_demosubtype.demosubtypeid"), nullable=True)
    # checksum     = Column(String(255), nullable=False)

class DemoType(Base):
    __tablename__ = "vpv_demotype"
    demotypeid  = Column(Integer, primary_key=True)
    name        = Column(String(25), nullable=False)
    description = Column(String(100), nullable=False)

class DemoSubType(Base):
    __tablename__ = "vpv_demosubtype"
    demosubtypeid = Column(Integer, primary_key=True)
    name          = Column(String(25), nullable=False)
    description   = Column(String(100), nullable=False)

class Demographic(Base):
    __tablename__ = "vpv_demographics"
    demographicid = Column(Integer, primary_key=True)
    demotypeid    = Column(Integer, ForeignKey("vpv_demotype.demotypeid"), nullable=False)
    demosubtypeid = Column(Integer, ForeignKey("vpv_demosubtype.demosubtypeid"), nullable=False)
    userid        = Column(Integer, ForeignKey("vpv_Users.idUser"), nullable=False)
    name          = Column(String(50), nullable=False)
    # checksum      = Column(String(255), nullable=True)

    demo_type = relationship("DemoType")
    demo_sub  = relationship("DemoSubType")
    user      = relationship("User")

class EncryptionKey(Base):
    __tablename__ = "vpv_encryptionkeys"

    keyid         = Column(Integer, primary_key=True, autoincrement=True)
    userid        = Column(Integer, ForeignKey("vpv_Users.idUser"), nullable=False)
    key           = Column(String(255), nullable=False)  # Asume que es nvarchar(255)
    creationDate  = Column(DateTime, nullable=False)
    enable        = Column(Boolean, nullable=False)
    # checksum      = Column(String(255), nullable=False)

    # Relación con el usuario
    # user = relationship("User", back_populates="encryption_keys")
    
class Voter(Base):
    __tablename__ = "vpv_Voter"

    idVoter = Column("idVoter", Integer, primary_key=True, nullable=False)
    age     = Column("age", Integer, nullable=False)
    idUser  = Column("idUser", Integer, ForeignKey("vpv_Users.idUser"), nullable=True)
    checksum= Column("checksum", LargeBinary, nullable=False)
    
class BlindToken(Base):
    __tablename__ = "vpv_BlindTokens"

    idToken      = Column("idToken", UNIQUEIDENTIFIER, primary_key=True, default=uuid.uuid4, nullable=False)
    used         = Column("used", Boolean, nullable=False, default=False)
    creacionDate = Column("creacionDate", DateTime, nullable=False, server_default=func.getdate())
    usedDate     = Column("usedDate", DateTime, nullable=True)
    checksum     = Column("checksum", LargeBinary, nullable=False)
    
    
class Vote(Base):
    __tablename__ = "vpv_Votes"

    idVote             = Column("idVote", Integer, primary_key=True)
    idVotingQuestion   = Column("idVotingQuestion", Integer, ForeignKey("vpv_votingQuestions.idVotingQuestions"), nullable=False)
    idVotingConfig     = Column("idVotingConfig", Integer, ForeignKey("vpv_votingConfigurations.idVotingConfig"), nullable=False)
    creationDate       = Column("creationDate", DateTime, nullable=False, server_default=func.getdate())
    idToken            = Column("idToken", UNIQUEIDENTIFIER, nullable=False)
    idVoter            = Column("idVoter", Integer, ForeignKey("vpv_Voter.idVoter"), nullable=False)
    idOptionQuestion   = Column("idOptionQuestion", Integer, ForeignKey("vpv_optionsQuestion.idOptionQuestion"), nullable=False)
    checksum           = Column("checksum", LargeBinary, nullable=False)

    # Relaciones opcionales
    question = relationship("VotingQuestion", back_populates="votes")
    voter    = relationship("Voter", back_populates="votes")
    option   = relationship("OptionQuestion")

class VotesTaken(Base):
    __tablename__ = "vpv_VotesTaken"

    idVoteTaken        = Column("idVoteTaken", Integer, primary_key=True)
    idUser             = Column("idUser", Integer, ForeignKey("vpv_Users.idUser"), nullable=False)
    idVotingQuestions  = Column("idVotingQuestions", Integer, ForeignKey("vpv_votingQuestions.idVotingQuestions"), nullable=False)
    creacionDate       = Column("creacionDate", DateTime, nullable=False, server_default=func.getdate())
    checksum           = Column("checksum", LargeBinary, nullable=False)

    user     = relationship("User")
    question = relationship("VotingQuestion")

class VoteValue(Base):
    __tablename__ = "vpv_voteValues"

    idVoteValue        = Column("idVoteValue", Integer, primary_key=True)
    value1             = Column("value1", LargeBinary(100), nullable=False)
    value2             = Column("value2", LargeBinary(100), nullable=False)
    idVote             = Column("idVote", Integer, ForeignKey("vpv_Votes.idVote"), nullable=False)
    checksum           = Column("checksum", LargeBinary, nullable=False)

    vote = relationship("Vote", back_populates="values")

# Ajustes en los modelos relacionados:
VotingQuestion.votes = relationship("Vote", back_populates="question")
Voter.votes          = relationship("Vote", back_populates="voter")
Vote.values          = relationship("VoteValue", back_populates="vote")



class ResultsPerOption(Base):
    __tablename__ = 'vpv_ResultsPerOption'

    idResultsPerOption = Column(Integer, primary_key=True, autoincrement=True)
    idOptionQuestion   = Column(Integer, ForeignKey('vpv_optionsQuestion.idOptionQuestion'), nullable=False)
    idVotingQuestions  = Column(Integer, ForeignKey('vpv_votingQuestions.idVotingQuestions'), nullable=False)
    votesCount         = Column(BigInteger, nullable=False)
    votesPercentage    = Column(DECIMAL(5,2), nullable=False)
    winner             = Column(Boolean, nullable=False)
    enable             = Column(Boolean, default=True, nullable=False)
    creationDate       = Column(DateTime, server_default=func.getdate(), nullable=False)
    checksum           = Column(String(250), nullable=False)
    idVotingConfig     = Column(Integer, ForeignKey('vpv_votingConfigurations.idVotingConfig'), nullable=False)
    average            = Column(DECIMAL(5,2), nullable=True)

    option   = relationship('OptionQuestion')
    question = relationship('VotingQuestion')
    config   = relationship('VotingConfiguration')
    



class Question(Base):
    __tablename__ = "vpv_questions"
    idQuestion      = Column(Integer, primary_key=True)
    idQuestionType  = Column(Integer, nullable=False)
    description     = Column(String(1000), nullable=False)
    creationDate    = Column(DateTime, nullable=False)
    checksum        = Column(NVARCHAR(550), nullable=True)

    # Una pregunta puede estar en muchas configuraciones de votación
    # voting_links    = relationship("VotingQuestion", back_populates="question")
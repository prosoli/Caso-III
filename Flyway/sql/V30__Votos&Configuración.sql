-- Ajuste para relacionar votos a la configuración de los mismos
ALTER TABLE vpv_Votes
ADD idVotingConfig INT; 
                        
ALTER TABLE vpv_Votes
ADD CONSTRAINT FK_vpvVotes_idVotingConfig
FOREIGN KEY (idVotingConfig)
REFERENCES vpv_votingConfigurations (idVotingConfig);

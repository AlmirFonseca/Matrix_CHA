CREATE TABLE UnidadeFederativa
(
  UF CHAR(2) NOT NULL,
  UFEstadoNome VARCHAR(255) NOT NULL,
  PRIMARY KEY (UF)
);

CREATE TABLE CEP
(
  CEP CHAR(8) NOT NULL,
  CEPCidade VARCHAR(255) NOT NULL,
  UF CHAR(2) NOT NULL,
  PRIMARY KEY (CEP),
--   FOREIGN KEY (UF) REFERENCES UnidadeFederativa(UF)
);

CREATE TABLE Funcionario
(
  FuncionarioPrimeiroNome VARCHAR(255) NOT NULL,
  FuncionarioultimoNome VARCHAR(255) NOT NULL,
  FuncionarioCPF CHAR(11) NOT NULL,
  FuncionarioDataNascimento DATE NOT NULL,
  FuncionarioCargo VARCHAR(255) NOT NULL,
  FuncionarioSalario FLOAT NOT NULL,
  EnderecoID CHAR(4) NOT NULL,
  PRIMARY KEY (FuncionarioCPF),
--   FOREIGN KEY (EnderecoID) REFERENCES Endereco(EnderecoID)
);

CREATE TABLE FuncionarioCorretor
(
  CorretorRegistro CHAR(7) NOT NULL,
  CorretorOrcamento FLOAT NOT NULL,
  FuncionarioCPF CHAR(11) NOT NULL,
  PRIMARY KEY (FuncionarioCPF),
--   FOREIGN KEY (FuncionarioCPF) REFERENCES Funcionario(FuncionarioCPF),
  UNIQUE (CorretorRegistro)
);

CREATE TABLE Regiao
(
  RegiaoID INT NOT NULL,
  FuncionarioCPF CHAR(11) NOT NULL,
  PRIMARY KEY (RegiaoID, FuncionarioCPF),
--   FOREIGN KEY (FuncionarioCPF) REFERENCES FuncionarioCorretor(FuncionarioCPF)
);

CREATE TABLE Imovel
(
  ImovelID CHAR(5) NOT NULL,
  ImovelTipo VARCHAR(255) NOT NULL,
  ImovelQuartos INT NOT NULL,
  ImovelBanheiros INT NOT NULL,
  ImovelGaragem INT NOT NULL,
  ImovelMetragem INT NOT NULL,
  ImovelValor FLOAT NOT NULL,
  ImovelDisponibilidade INT NOT NULL,
  EnderecoID CHAR(4) NOT NULL,
  PRIMARY KEY (ImovelID),
--   FOREIGN KEY (EnderecoID) REFERENCES Endereco(EnderecoID)
);

CREATE TABLE Anuncio
(
  AnuncioID CHAR(6) NOT NULL,
  AnuncioMeio VARCHAR(255) NOT NULL,
  AnuncioPreco FLOAT NOT NULL,
  ImovelID CHAR(5) NOT NULL,
  FuncionarioCPF CHAR(11) NOT NULL,
  PRIMARY KEY (AnuncioID),
--   FOREIGN KEY (ImovelID) REFERENCES Imovel(ImovelID),
--   FOREIGN KEY (FuncionarioCPF) REFERENCES FuncionarioCorretor(FuncionarioCPF)
);

CREATE TABLE Contato
(
  ContatoID CHAR(6) NOT NULL,
  ContatoMeio VARCHAR(255) NOT NULL,
  ContatoNatureza VARCHAR(255) NOT NULL,
  ContatoNome VARCHAR(255) NOT NULL,
  ContatoTelefone CHAR(11) NOT NULL,
  FuncionarioCPF CHAR(11) NOT NULL,
  ImovelID CHAR(5),
  PRIMARY KEY (ContatoID, FuncionarioCPF, ImovelID),
--   FOREIGN KEY (FuncionarioCPF) REFERENCES Funcionario(FuncionarioCPF),
--   FOREIGN KEY (ImovelID) REFERENCES Imovel(ImovelID)
);

CREATE TABLE TransacaoVenda
(
  TransacaoVendaID CHAR(6) NOT NULL,
  TransacaoVendaValor FLOAT NOT NULL,
  TransacaoVendaData DATE NOT NULL,
  ImovelID CHAR(5) NOT NULL,
  FuncionarioCPF CHAR(11) NOT NULL,
  PRIMARY KEY (TransacaoVendaID, ImovelID, FuncionarioCPF),
--   FOREIGN KEY (ImovelID) REFERENCES Imovel(ImovelID),
--   FOREIGN KEY (FuncionarioCPF) REFERENCES FuncionarioCorretor(FuncionarioCPF)
);

CREATE TABLE Cliente
(
  ClientePrimeiroNome VARCHAR(255) NOT NULL,
  ClienteultimoNome VARCHAR(255) NOT NULL,
  ClienteCPF CHAR(11) NOT NULL,
  ClienteDataNascimento DATE NOT NULL,
  ClienteTelefone CHAR(11) NOT NULL,
  ContatoID CHAR(6) NOT NULL,
  EnderecoID CHAR(4) NOT NULL,
  PRIMARY KEY (ClienteCPF),
--   FOREIGN KEY (ContatoID) REFERENCES Contato(ContatoID),
--   FOREIGN KEY (EnderecoID) REFERENCES Endereco(EnderecoID)
);

CREATE TABLE Endereco
(
  EnderecoID CHAR(4) NOT NULL,
  EnderecoLogradouro VARCHAR(255) NOT NULL,
  EnderecoNumero VARCHAR(255),
  EnderecoComplemento VARCHAR(255),
  EnderecoZona CHAR(1) NOT NULL,
  EnderecoBairro VARCHAR(255) NOT NULL,
  CEP CHAR(8) NOT NULL,
  RegiaoID INT,
  PRIMARY KEY (EnderecoID),
--   FOREIGN KEY (CEP) REFERENCES CEP(CEP),
--   FOREIGN KEY (RegiaoID) REFERENCES Regiao(RegiaoID)
);

CREATE TABLE Pertence
(
  ImovelID CHAR(5) NOT NULL,
  ClienteCPF CHAR(11) NOT NULL,
  PRIMARY KEY (ImovelID, ClienteCPF),
--   FOREIGN KEY (ImovelID) REFERENCES Imovel(ImovelID),
--   FOREIGN KEY (ClienteCPF) REFERENCES Cliente(ClienteCPF)
);

CREATE TABLE ClienteParticipa
(
  Tipo CHAR(1) NOT NULL,
  TransacaoVendaID CHAR(6) NOT NULL,
  ClienteCPF CHAR(11) NOT NULL,
  PRIMARY KEY (TransacaoVendaID, ClienteCPF),
--   FOREIGN KEY (TransacaoVendaID) REFERENCES TransacaoVenda(TransacaoVendaID),
--   FOREIGN KEY (ClienteCPF) REFERENCES Cliente(ClienteCPF)
);

ALTER TABLE CEP ADD CONSTRAINT CEP_UF_FK
    FOREIGN KEY (UF) REFERENCES UnidadeFederativa(UF);

ALTER TABLE Funcionario ADD CONSTRAINT Funcionario_EnderecoID_FK
    FOREIGN KEY (EnderecoID) REFERENCES Endereco(EnderecoID);

ALTER TABLE FuncionarioCorretor ADD CONSTRAINT FuncionarioCorretor_FuncionarioCPF_FK
    FOREIGN KEY (FuncionarioCPF) REFERENCES Funcionario(FuncionarioCPF);

ALTER TABLE Regiao ADD CONSTRAINT Regiao_FuncionarioCPF_FK
    FOREIGN KEY (FuncionarioCPF) REFERENCES FuncionarioCorretor(FuncionarioCPF);

ALTER TABLE Imovel ADD CONSTRAINT Imovel_EnderecoID_FK
    FOREIGN KEY (EnderecoID) REFERENCES Endereco(EnderecoID);

ALTER TABLE Anuncio ADD CONSTRAINT Anuncio_ImovelID_FK
    FOREIGN KEY (ImovelID) REFERENCES Imovel(ImovelID);

ALTER TABLE Anuncio ADD CONSTRAINT Anuncio_FuncionarioCPF_FK
    FOREIGN KEY (FuncionarioCPF) REFERENCES FuncionarioCorretor(FuncionarioCPF);

ALTER TABLE Contato ADD CONSTRAINT Contato_FuncionarioCPF_FK
    FOREIGN KEY (FuncionarioCPF) REFERENCES Funcionario(FuncionarioCPF);

ALTER TABLE Contato ADD CONSTRAINT Contato_ImovelID_FK
    FOREIGN KEY (ImovelID) REFERENCES Imovel(ImovelID);

ALTER TABLE TransacaoVenda ADD CONSTRAINT TransacaoVenda_ImovelID_FK
    FOREIGN KEY (ImovelID) REFERENCES Imovel(ImovelID);

ALTER TABLE TransacaoVenda ADD CONSTRAINT TransacaoVenda_FuncionarioCPF_FK
    FOREIGN KEY (FuncionarioCPF) REFERENCES FuncionarioCorretor(FuncionarioCPF);

ALTER TABLE Cliente ADD CONSTRAINT Cliente_ContatoID_FK
    FOREIGN KEY (ContatoID) REFERENCES Contato(ContatoID);

ALTER TABLE Cliente ADD CONSTRAINT Cliente_EnderecoID_FK
    FOREIGN KEY (EnderecoID) REFERENCES Endereco(EnderecoID);

ALTER TABLE Endereco ADD CONSTRAINT Endereco_CEP_FK
    FOREIGN KEY (CEP) REFERENCES CEP(CEP);

ALTER TABLE Endereco ADD CONSTRAINT Endereco_RegiaoID_FK
    FOREIGN KEY (RegiaoID) REFERENCES Regiao(RegiaoID);

ALTER TABLE Pertence ADD CONSTRAINT Pertence_ImovelID_FK
    FOREIGN KEY (ImovelID) REFERENCES Imovel(ImovelID);

ALTER TABLE Pertence ADD CONSTRAINT Pertence_ClienteCPF_FK
    FOREIGN KEY (ClienteCPF) REFERENCES Cliente(ClienteCPF);

ALTER TABLE ClienteParticipa ADD CONSTRAINT ClienteParticipa_TransacaoVendaID_FK
    FOREIGN KEY (TransacaoVendaID) REFERENCES TransacaoVenda(TransacaoVendaID);

ALTER TABLE ClienteParticipa ADD CONSTRAINT ClienteParticipa_ClienteCPF_FK
    FOREIGN KEY (ClienteCPF) REFERENCES Cliente(ClienteCPF);

CREATE TABLE Endereco
(
  EnderecoKey UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL,
  EnderecoID CHAR(4) NOT NULL,
  EnderecoLogradouro VARCHAR(30) NOT NULL,
  EnderecoBairro VARCHAR(16),
  EnderecoMunicipio VARCHAR(16),
  EnderecoEstado CHAR(2) NOT NULL,
  PRIMARY KEY (EnderecoKey),
  UNIQUE (EnderecoID)
);

CREATE TABLE Comprador
(
  CompradorKey UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL,
  CompradorID CHAR(5) NOT NULL,
  CompradorPrimeiroNome VARCHAR(16) NOT NULL,
  CompradorÚltimoNome VARCHAR(16) NOT NULL,
  CompradorCPF CHAR(11) NOT NULL,
  CompradorDataNascimento DATE NOT NULL,
  CompradorTelefone CHAR(11) NOT NULL,
  PRIMARY KEY (CompradorKey),
  UNIQUE (CompradorID),
  UNIQUE (CompradorCPF)
);

CREATE TABLE Corretor
(
  CorretorKey UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL,
  CorretorPrimeiroNome VARCHAR(16) NOT NULL,
  CorretorUltimoNome VARCHAR(16) NOT NULL,
  CorretorCPF CHAR(11) NOT NULL,
  CorretorDataNascimento DATE NOT NULL,
  CorretorSalario INT NOT NULL,
  CorretorRegistro CHAR(7) NOT NULL,
  CorretorOrcamento INT NOT NULL,
  CorretorRegiao CHAR(1) NOT NULL,
  PRIMARY KEY (CorretorKey),
  UNIQUE (CorretorRegistro),
  UNIQUE (CorretorCPF)
);

CREATE TABLE Data
(
  DataKey UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL,
  Ano INT NOT NULL,
  Trimestre INT NOT NULL,
  Mes INT NOT NULL,
  DiaDoMes INT NOT NULL,
  DiaDaSemana VARCHAR(20) NOT NULL,
  DataCompleta DATETIME NOT NULL,
  PRIMARY KEY (DataKey)
);

CREATE TABLE Anuncio
(
  AnuncioKey UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL,
  AnuncioID CHAR(6) NOT NULL,
  AnuncioMeio VARCHAR(10) NOT NULL,
  AnuncioPreco INT NOT NULL,
  PRIMARY KEY (AnuncioKey),
  UNIQUE (AnuncioID)
);

CREATE TABLE Vendedor
(
  VendedorKey UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL,
  VendedorID CHAR(5) NOT NULL,
  VendedorPrimeiroNome VARCHAR(16) NOT NULL,
  VendedorUltimoNome VARCHAR(16) NOT NULL,
  VendedorCPF CHAR(11)NOT NULL,
  VendedorDataNascimento DATE NOT NULL,
  VendedorTelefone CHAR(11) NOT NULL,
  PRIMARY KEY (VendedorKey),
  UNIQUE (VendedorID),
  UNIQUE (VendedorCPF)
);

CREATE TABLE Receita
(
  DataKey UNIQUEIDENTIFIER NOT NULL,
  EnderecoKey UNIQUEIDENTIFIER NOT NULL,
  Valor FLOAT NOT NULL,
  PRIMARY KEY (DataKey, EnderecoKey),
  FOREIGN KEY (DataKey) REFERENCES Data(DataKey),
  FOREIGN KEY (EnderecoKey) REFERENCES Endereco(EnderecoKey)
);

CREATE TABLE ReceitaDetalhada
(
  Valor FLOAT NOT NULL,
  TransacaoID CHAR(6) NOT NULL,
  DataKey UNIQUEIDENTIFIER NOT NULL,
  CorretorKey UNIQUEIDENTIFIER NOT NULL,
  EnderecoKey UNIQUEIDENTIFIER NOT NULL,
  AnuncioKey UNIQUEIDENTIFIER NOT NULL,
  CompradorKey UNIQUEIDENTIFIER NOT NULL,
  VendedorKey UNIQUEIDENTIFIER NOT NULL,
  PRIMARY KEY (TransacaoID, AnuncioKey, CompradorKey, VendedorKey),
  FOREIGN KEY (DataKey) REFERENCES Data(DataKey),
  FOREIGN KEY (CorretorKey) REFERENCES Corretor(CorretorKey),
  FOREIGN KEY (AnuncioKey) REFERENCES Anuncio(AnuncioKey),
  FOREIGN KEY (CompradorKey) REFERENCES Comprador(CompradorKey),
  FOREIGN KEY (VendedorKey) REFERENCES Vendedor(VendedorKey)
  );

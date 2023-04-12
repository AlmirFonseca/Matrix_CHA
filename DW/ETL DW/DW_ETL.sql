
INSERT INTO [DWMatrix_CHA_CHO].[dbo].[Endereco]
select 
	newid(),
 	e.EnderecoID,
  	e.EnderecoLogradouro,
 	e.EnderecoBairro,
  	c.CEPCidade,
  	c.UF
from
	Endereco e inner join CEP c on e.CEP = c.CEP;


INSERT INTO [DWMatrix_CHA_CHO].[dbo].[Comprador]
select 
  newid(),
  c.ClienteCPF,
  c.ClientePrimeiroNome,
  c.ClienteUltimoNome,
  c.ClienteDataNascimento,
  c.ClienteTelefone
from
	Cliente c;


INSERT INTO [DWMatrix_CHA_CHO].[dbo].[Corretor]
select 
  newid(),
  f.FuncionarioPrimeiroNome,
  f.FuncionarioUltimoNome,
  f.FuncionarioCPF,
  f.FuncionarioDataNascimento,
  f.FuncionarioSalario,
  fc.CorretorRegistro,
  fc.CorretorOrcamento,
  r.RegiaoID
from
	Funcionario f inner join FuncionarioCorretor fc on f.FuncionarioCPF = fc.FuncionarioCPF
	inner join Regiao r on f.FuncionarioCPF = r.FuncionarioCPF;


insert into [DWMatrix_CHA_CHO].[dbo].[Data]
select
	newid(),
      a.ano,
      a.trimestre,
      a.mes,
      a.dia,
      a.diasemana,
      a.datacompleta
from (
select distinct
	datepart(year,t.TransacaoVendaData) as ano,
	datepart(quarter,t.TransacaoVendaData) as trimestre,
	datepart(month,t.TransacaoVendaData) as mes,
	datepart(day,t.TransacaoVendaData) as dia,
	datename(weekday,t.TransacaoVendaData) as diasemana,
	cast(t.TransacaoVendaData as date) as datacompleta

from 
	TransacaoVenda t 
where cast(t.TransacaoVendaData as date) not in (select [DataCompleta] from [DWMatrix_CHA_CHO].[dbo].Data)
	) as a;



INSERT INTO [DWMatrix_CHA_CHO].[dbo].[Anuncio]
select 
  newid(),
  a.AnuncioID,
  a.AnuncioMeio,
  a.AnuncioPreco
from
	Anuncio a;



INSERT INTO [DWMatrix_CHA_CHO].[dbo].[Vendedor]
select 
  newid(),
  c.ClientePrimeiroNome,
  c.ClienteUltimoNome,
  c.ClienteCPF,
  c.ClienteDataNascimento,
  c.ClienteTelefone
from
	Cliente c;


insert into DWMatrix_CHA_CHO.dbo.[Receita]
select
	dwd.DataKey,
	dwe.EnderecoKey,
	t.TransacaoVendaValor
from
	TransacaoVenda t inner join Imovel i on t.ImovelID=i.ImovelID
	inner join [DWMatrix_CHA_CHO].[dbo].Data dwd on dwd.DataCompleta=cast(t.TransacaoVendaData as date)
	inner join DWMatrix_CHA_CHO.dbo.Endereco dwe  on i.EnderecoID=dwe.EnderecoID
	;


select * from  TransacaoVenda;

insert into DWMatrix_CHA_CHO.dbo.[ReceitaDetalhada]
SELECT 
    t.TransacaoVendaValor,
    t.TransacaoVendaID,
    dwd.DataKey,
    dwcor.CorretorKey,
    dwe.EnderecoKey,
    dwa.AnuncioKey,
    dwc.CompradorKey,
    dwv.VendedorKey
FROM
    TransacaoVenda t
    INNER JOIN [DWMatrix_CHA_CHO].[dbo].Data dwd ON dwd.DataCompleta = CAST(t.TransacaoVendaData AS DATE)
	INNER JOIN DWMatrix_CHA_CHO.dbo.Corretor dwcor ON t.FuncionarioCPF = dwcor.CorretorCPF
    INNER JOIN Imovel i ON t.ImovelID = i.ImovelID
    INNER JOIN DWMatrix_CHA_CHO.dbo.Endereco dwe ON i.EnderecoID = dwe.EnderecoID
    INNER JOIN Anuncio ON Anuncio.ImovelID = i.ImovelID
    INNER JOIN DWMatrix_CHA_CHO.dbo.Anuncio dwa ON Anuncio.AnuncioID = dwa.AnuncioID
	INNER JOIN ClienteParticipa cp ON cp.TransacaoVendaID = t.TransacaoVendaID
    INNER JOIN [DWMatrix_CHA_CHO].[dbo].Comprador dwc ON dwc.CompradorCPF = cp.ClienteCPF
    INNER JOIN Pertence ON Pertence.ImovelID = i.ImovelID
    INNER JOIN [DWMatrix_CHA_CHO].[dbo].Vendedor dwv ON dwv.VendedorCPF = Pertence.ClienteCPF
	;

use DWMatrix_CHA_CHO;

create view FatoReceita as
select
  r.TransacaoID,
  r.Valor,
  r.Valor * 0.06 as Comissao,
  CONCAT(c.CorretorPrimeiroNome, ' ', c.CorretorUltimoNome) as Corretor,
  CONCAT(co.CompradorPrimeiroNome, ' ', co.CompradorÚltimoNome) as Comprador,
  CONCAT(v.VendedorPrimeiroNome, ' ', v.VendedorUltimoNome) as Vendedor,
  a.AnuncioPreco,
  e.EnderecoEstado,
  e.EnderecoMunicipio,
  ISNULL(e.EnderecoBairro, 'ZONA RURAL') as Bairro,
  e.EnderecoLogradouro,
  d.DataCompleta,
  d.DiaDaSemana,
  d.DiaDoMes,
  d.Mes,
  d.Trimestre,
  d.Ano
from
  [DWMatrix_CHA_CHO].[dbo].[ReceitaDetalhada] r 
  inner join [DWMatrix_CHA_CHO].[dbo].Data d on r.DataKey=d.DataKey
  inner join [DWMatrix_CHA_CHO].[dbo].Corretor c on r.CorretorKey=c.CorretorKey
  inner join [DWMatrix_CHA_CHO].[dbo].Endereco e on r.EnderecoKey=e.EnderecoKey
  inner join [DWMatrix_CHA_CHO].[dbo].Anuncio a on r.AnuncioKey=a.AnuncioKey
  inner join [DWMatrix_CHA_CHO].[dbo].Comprador co on r.CompradorKey=co.CompradorKey
  inner join [DWMatrix_CHA_CHO].[dbo].Vendedor v on r.VendedorKey=v.VendedorKey
go

select * from FatoReceita;

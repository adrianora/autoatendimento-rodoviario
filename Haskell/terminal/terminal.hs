import System.IO
import Data.List

main:: IO()
main = do
  mensagemBoasVindas
  escolhaTerminal
  entrada <- getLine
  if entrada == "1" then putStrLn "novo" else putStrLn "ilin"

usuariosCadastrados:: [String]
usuariosCadastrados = []

addUsuario:: String -> [String] -> [String]
addUsuario user list = user:list

usuarioLogado:: String
usuarioLogado = ""

mensagemBoasVindas = putStrLn "======================\n----- Bem vindo! -----\n======================"

escolhaTerminal = putStrLn "Em qual terminal você se encontra?\n1. MONTEIRO\n2. CAMPINA GRANDE\n3. JOAO PESSOA\n4. SOUSA\n======================\nOpção:"


-- TERMINAL

cidades = [("MT","MONTEIRO"),("CG","CAMPINA GRANDE"),("JP","JOAO PESSOA"),("SS","SOUSA")]
taxa = 1.5

split str = case break (=='-') str of
                (a, _comma:b) -> a : split b
                (a, _empty)   -> [a]


toString :: [String] -> IO ()
toString array = mapM_ (putStrLn.show) array


selec_prim [x, _] = x
selec_sec [_, xs] = xs

reverseList [] = []
reverseList (x:xs) = reverseList xs ++ [x]


getCidadeByCodigo :: (String, String) -> [String] -> String -- metodo auxiliar
getCidadeByCodigo (cod,cidade) sigla
      | (cod == selec_prim sigla) = cidade
      | (cod == selec_sec sigla) = cidade
      | otherwise = ""

lista [] sigla = [] -- metodo auxiliar
lista (x:xs) sigla
  | (getCidadeByCodigo x sigla) == "" = lista xs sigla
  | otherwise = getCidadeByCodigo x sigla : lista xs sigla

concatenate:: [String] -> String -- metodo auxiliar
concatenate cidades = intercalate " - " cidades

-- PARA ACESSO DIGITAR SIGLA SEM ESPACO ENTRE AS SIGLAS DE CADA CIDADE EX.: "CG-SS" E NÃO "CG - SS"
getCidadeFinal:: String -> String
getCidadeFinal codigoByUsuario =
  concatenate (lista cidades (split codigoByUsuario))

empresas = ["Real Bus", "Viacao Sao Jose", "Pontual Transporte", "Travel Bus"]
rotas = [("MT-CG","CG-MT"),("CG-JP","JP-CG"),("MT-JP","JP-MT"),("MT-SS","SS-MT"),("SS-CG","CG-SS"),("SS-JP","JP-SS")]

busca_prim (x, _) = x
busca_sec (_, xs) = xs

getValoresByCodigo :: (String, String) -> String -> Int -- metodo auxiliar
getValoresByCodigo (sigla1,sigla2) siglaRota
      | (sigla1 == siglaRota) = 1
      | (sigla2 == siglaRota) = 2
      | otherwise = 0

searchRota [] sigla = 0
searchRota (x:xs) sigla -- metodo auxiliar
      | (getValoresByCodigo x sigla) == 0 = 1 + (searchRota xs sigla)
      | otherwise = 1 + (getValoresByCodigo x sigla)

retornaPrecos:: String -> Float -- O VALOR A SER DADO PARA ACESSO DO METODO É A SIGLA DA ROTA QUE O USUARIO IRÁ PERCORRER. EX.: "CG-JP", "SS-MT"
retornaPrecos sigla
      | (searchRota rotas sigla) <= 3 = 26.0
      | (searchRota rotas sigla) <= 5 = 28.0
      | (searchRota rotas sigla) <= 6 = 32.0
      | otherwise = 35.0


destinosEValores :: (String,String) -> [String] -- metodo auxiliar
destinosEValores (sigla1, sigla2) =
      [getCidadeFinal sigla1 ++ " - R$ " ++ show (retornaPrecos sigla1)] ++ [getCidadeFinal sigla2 ++ " - R$ " ++ show (retornaPrecos sigla2)]


listaRotas = ["MONTEIRO - CAMPINA GRANDE - R$ 26.0","CAMPINA GRANDE -  MONTEIRO - R$ 26.0","CAMPINA GRANDE - JOAO PESSOA - R$ 26.0","JOAO PESSOA - CAMPINA GRANDE - R$ 28.0","MONTEIRO - JOAO PESSOA - R$ 28.0","JOAO PESSOA - MONTEIRO - R$ 28.0","MONTEIRO - SOUSA - R$ 28.0","SOUSA - MONTEIRO - R$ 32.0","CAMPINA GRANDE - SOUSA - R$ 32.0","SOUSA - CAMPINA GRANDE - R$ 35.0","JOAO PESSOA - SOUSA - R$ 35.0"," SOUSA - JOAO PESSOA - R$ 35.0"]
getRotasComValores = toString listaRotas -- METODO QUE PRINTA TODAS AS ROTAS COM VALORES, NENHUM PARAMETRO DE ENTRADA É NECESSARIO

getTaxaDeEmbarque :: Int -> Float -- INFORMAR A QUANTIDADE DE MALAS
getTaxaDeEmbarque qtdMalas = fromIntegral (qtdMalas) * taxa

getNomeCidade [] sigla = []
getNomeCidade (x:xs) sigla
      | sigla == (busca_prim x) = busca_sec x
      | otherwise = getNomeCidade xs sigla

getInfo :: String -> String -- -- FUNCAO FINAL A SER UTILIZADA, ENTRADA É A SIGLA DO TERMINAL DE ONDE ESTA SENDO FEITA A OPERACAO, EX.: "CG"
getInfo codigo = "Terminal Rodoviario de " ++ (getNomeCidade cidades codigo) ++ " Empresas disponiveis: Real Bus, Viacao Sao Jose, Pontual Transporte, Travel Bus"

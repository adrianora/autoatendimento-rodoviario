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


--split :: String -> Char -> [String]
--split str delim = let (start, end) = break (== delim) str
--                    in start : if null end then [] else split (tail end) delim


split str = case break (=='-') str of
                (a, _comma:b) -> a : split b
                (a, _empty)   -> [a]


toString :: [String] -> IO ()
toString array = mapM_ (putStrLn.show) array


selec_prim [x, _] = x
selec_sec [_, xs] = xs
--reverseList [] = []
--reverseList (x:xs) = reverseList xs ++ [x]

-- getCidades
getCidadeByCodigo :: (String, String) -> [String] -> String
getCidadeByCodigo (cod,cidade) sigla
      | (cod == selec_prim sigla) = cidade
      | (cod == selec_sec sigla) = cidade
      | otherwise = ""

lista [] sigla = []
lista (x:xs) sigla
  | (getCidadeByCodigo x sigla) == "" = lista xs sigla
  | otherwise = getCidadeByCodigo x sigla : lista xs sigla

concatenate:: [String] -> String
concatenate cidades = intercalate " - " cidades

getCidadeFinal:: String -> String
getCidadeFinal codigoByUsuario =
  concatenate (lista cidades (split codigoByUsuario))


empresas = ["Real Bus", "Viacao Sao Jose", "Pontual Transporte", "Travel Bus"]
rotas = [("MT-CG","CG-MT"),("CG-JP","JP-CG"),("MT-JP","JP-MT"),("MT-SS","SS-MT"),("SS-CG","CG-SS"),("SS-JP","JP-SS")]

busca_prim (x, _) = x
busca_sec (_, xs) = xs

getValoresByCodigo :: (String, String) -> String -> Int
getValoresByCodigo (sigla1,sigla2) siglaRota
      | (sigla1 == siglaRota) = 1
      | (sigla2 == siglaRota) = 2
      | otherwise = 0

--getRota [] sigla _ = 0
--getRota (x:xs) sigla cont
--  | ((getValoresByCodigo x sigla) == 0) = cont + (getRota xs sigla cont++)
--  | otherwise = (getValoresByCodigo x sigla) + getRota xs sigla cont++

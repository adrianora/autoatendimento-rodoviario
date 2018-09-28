//
// Created by joaoc on 26/09/2018.
//

#include <iostream>
#include <stdio.h>
#include <string>
#include <vector>
#include <array>
#define ARRAYLEN(arr) (sizeof(arr) / sizeof(arr[0]))

using namespace std;

// taxa padrão para cobrança de embarque
const double taxa = 1.5;
// lista de cidades disponiveis onde há terminais
string cidades[4] = {"Campina Grande","Joao Pessoa","Sousa","Monteiro"};
// sigla é usado assim para melhor busca e iteração
string sigla[4] = {"CG", "JP", "SS", "MT"};
/* lista de empresas disponiveis, cada empresa é responsavel por determinadas rotas
 * note que o index de empresas interage com o index de valores e rotaEmpresas
 * sendo cada index de rotaEmpresas as rotas que cada empresa é responsavel
  */
string empresas[4] = {"Real Bus", "Viacao Sao Jose", "Pontual Transporte", "Travel Bus"};
// O index de rotas equivale com o index de estDeTempoMinutos para iteração
vector<string> rotas = {"MT - CG", "MT - JP", "MT - SS",
                        "SS - CG", "SS - JP", "SS - MT",
                        "CG - JP", "CG - SS", "CG-MT",
                        "JP - CG", "JP - MT", "JP - SS"};
// Valores padrão para passagem
float valores[4] = {26.0, 28.0, 32.0, 35.0};
// array onde cada index armazena as rotas que cada empresa é responsavel
string rotaEmpresas[4] = {("MT - CG", "CG - MT", "CG - JP", "JP - CG"),
                          ("MT - JP", "JP - MT"),
                          ("MT - SS", "SS - MT", "SS - CG", "CG - SS"),
                          ("SS - JP", "JP - SS")};
// O index de estDeTempoMinutos equivale com o index de rotas para iteração
vector<string> estDeTempoMinutos = {"131","205","210",
                                    "241", "321","210",
                                    "80","240","126",
                                    "80","205","321"};
// Funçao que serve para fazer split com ' - ' como separador
vector<string> split(string codigo){
    vector<string> result;
    int achou, i = 0;
    while (codigo != "\0") {
        achou = codigo.find("-");
        for (int j = 0; j < achou; j++) {
            result[i] += codigo[j]; }
        codigo.erase(0, achou +1);
        i++; }
    return result; }

string toString(vector<string> array) {
    for (vector<string>::iterator it = array.begin(); it != array.end() ; it++)
        cout << *it << "\n"; }

// Recebe as siglas concatenadas com '-', faz uso do metodo privado split e a busca pela cidade
string getCidades(string codigo) {
    vector<string> sepSigla = split(codigo);
    vector<string> cidadeRetorno;
    for (int i = 0; i < sepSigla.size(); i++) {
        for (int j = 0; j < sigla->size() ; j++) {
            if(sepSigla[i] == sigla[j]) {
                cidadeRetorno.push_back(cidades[j]); }
        }
    }
    string retorno;
    for (int k = 0; k < cidadeRetorno.size(); k++) {
        if(k < cidadeRetorno.size() - 1) {
            retorno += cidadeRetorno[k] + " - ";
        } else {
            retorno += cidadeRetorno[k]; }
    }
    return retorno; }
// Busca e retorna o valor da rota através da sigla passada
double getValores(string sigla) {
    for (int i = 0; i < rotaEmpresas->size(); i++) {
        if (rotaEmpresas[i].find(sigla) != string::npos ) {
            return valores[i]; }
    }
}
// Imprime uma lista de rotas com seus respectivos valores
string destinosEValores() {
    vector<string> rotasValores;
    for (int i = 0; i < rotas.size(); i++) {
        string pegaRota = getCidades(rotas[i]) + " - R$ ";
        pegaRota += to_string(getValores(rotas[i]));
        rotasValores.push_back(pegaRota); }
    toString(rotasValores);
    //for (int j = 0; j < rotasValores.size(); ++j) {
       // cout << rotasValores[j] << "\n"; }
}

// Quando chamada ela retorna todas as rotas do itinerario com tempo em minutos
string getItinerario() {
    vector<string> itinerarios;

    for (int i = 0; i < rotas.size() ; i++) {
        string itn = getCidades(rotas[i]);
        itn+= " - ";
        itn += estDeTempoMinutos[i];
        itn += " minutos";
        itinerarios.push_back(itn); }
    toString(itinerarios);
}
// Funcao que imprime a empresas disponiveis
string getEmpresas() {
    vector<string> emp;
    for (int i = 0; i < ARRAYLEN(empresas) ; i++) {
        emp.push_back(empresas[i]); }
    toString(emp);
}
// Funcao que calcula taxa de embarque recebendo a quantidade de malas e retorna a taxa
double getTaxaDeEmbarque(int malas) {
    return malas * taxa; }
// Funcao que retorna informacoes do terminal
string getInfo(string codigo) {
    int indice;
    string result;
    for(int i = 0; i < (sizeof(sigla) / sizeof(sigla[0])); i++) {
        if(sigla[i] == codigo) {
            indice = i; }
    }

    result += "Terminal Rodoviario de ";
    result += cidades[indice] + ". \n";
    cout << result << "\n";
    cout << "Empresas disponiveis: " << "\n";
    getEmpresas();
}

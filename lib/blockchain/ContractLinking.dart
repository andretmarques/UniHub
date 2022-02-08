import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class ContractLinking extends ChangeNotifier {
  final String _rpcUrl = "http://3.122.235.21:8545";
  final String _wsUrl = "ws://3.122.235.21:8545/";
  final String _privateKey = "0xe7e87d09385ef384d2a0078b03738e35ef621989740c250de86c98684ed8d153";

  late Web3Client _client;
  bool isLoading = true;

  late String _abiCode;
  late EthereumAddress _contractAddress;

  late Credentials _credentials;

  late DeployedContract _contract;
  late ContractFunction _countryName;
  late ContractFunction _currentPopulation;
  late ContractFunction _set;
  late ContractFunction _decrement;
  late ContractFunction _increment;

  late String user;
  late String tokens;

  ContractLinking() {
    initialSetup();
  }

  initialSetup() async {
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {

    // Reading the contract abi
    final abiStringFile =
    await rootBundle.loadString("src/artifacts/Achandos.json");
    final jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);
    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
  }

  Future<void> getCredentials() async {
    _credentials = await _client.credentialsFromPrivateKey(_privateKey);
  }

  Future<void> getDeployedContract() async {

    // Telling Web3dart where our contract is declared.
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "Achandos"), _contractAddress);

    // Extracting the functions, declared in contract.
    _countryName = _contract.function("user");
    _currentPopulation = _contract.function("tokens");
    _set = _contract.function("set");
    _decrement = _contract.function("decrement");
    _increment = _contract.function("increment");

    getData();
  }

  getData() async {

    // Getting the current name and population declared in the smart contract.
    List name = await _client
        .call(contract: _contract, function: _countryName, params: []);
    List population = await _client
        .call(contract: _contract, function: _currentPopulation, params: []);
    user = name[0];
    tokens = population[0].toString();
    print("$user , $tokens");
    isLoading = false;
    notifyListeners();
  }

  addData(String nameData, BigInt countData) async {

    // Setting the countryName  and currentPopulation defined by the user
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _set,
            parameters: [nameData, countData]));
    getData();
  }

  increasePopulation(int incrementBy) async {

    // Increasing the currentPopulation
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _increment,
            parameters: [BigInt.from(incrementBy)]));
    getData();
  }

  decreasePopulation(int decrementBy) async {

    // Decreasing the currentPopulation
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _decrement,
            parameters: [BigInt.from(decrementBy)]));
    getData();
  }
}
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.4.21;
pragma experimental ABIEncoderV2;

contract Storage{
    uint CODE_SUCCESS = 0;
    uint FILE_NOT_EXIST = 3002;
    uint FILE_ALREADY_EXIST  = 3003;
    uint USER_NOT_EXIST = 3004;
    // 定义数据结构体  
    struct FileEvidence{
    string fileHash;   //文件哈希  
    string author;   //文件作者
    string time;  //文件时间
    string Fid;   //柜子假ID
    string WorkerID;    //工人ID
    string fileName;       //论文名
    bool storaged;   //flag
    }
 
    mapping(string => FileEvidence) filemap;

    // 定义事件 
    event updateInfo(string fileHash, string author, string fileName,string time,string Fid,string WorkerID);


    address[] userList;
    
    function saveEvidence(string memory fileHash,string memory author, string memory fileName,string memory time,string memory Fid,string memory WorkerID) public returns(uint code){
        //get filemap under sender
        FileEvidence storage fileEvidence = filemap[fileName];
        if (fileEvidence.storaged){
            return FILE_ALREADY_EXIST;
        }
        fileEvidence.fileHash = fileHash;
        fileEvidence.author = author;
        fileEvidence.time = time;
        fileEvidence.fileName = fileName;
        fileEvidence.Fid = Fid;
        fileEvidence.WorkerID = WorkerID;
        fileEvidence.storaged = true;
        // filemap[fileHash] = fileEvidence;
        // emit updateInfo(fileEvidence.fileHash,fileEvidence.fileUploadTime,fileEvidence.owner);
        return CODE_SUCCESS;
    }
     //0x0b7fc2e3E23D3c85c6A4E3DBd45e2c1ac803cD09
    function getEvidence(string memory fileName)  public view  returns(string memory) {
        //get filemap under sender
        FileEvidence memory fileEvidence = filemap[fileName];
        if (fileEvidence.storaged == false) {
            return "FILE_NOT_EXIST";
        }
        return fileEvidence.fileHash;
    }
}
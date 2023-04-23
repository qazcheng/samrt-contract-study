pragma solidity >0.4.24;
// pragma experimental ABIEncoderV2;
contract R_table{
  //定义一个合约，该合约具有合约地址，地址映射到角色表
    // address Raddress;
    // mapping(address=>Role_table) R_Rep;
    // Role_table rt;    
    struct Role_table{
      //定义角色结构体结构体，存入权限id，每个U_id对应一个Per_id的映射，len存储权限列表的长度
        string U_id;
        uint Per_id;
        // uint len;
    }
     mapping(string=>Role_table) rt;
    // constructor(address R_address) public {
    //   //构造函数，初始化地址
    //     Raddress =R_address;
    //     rt = R_Rep[Raddress];
        // rt.len = 0;
    // }
    
    function S_table_add(string memory U_id, uint Per_id) public {
      //U_id和Per_id的键值对增加
        // bytes memory b = bytes(U_id);
        rt[U_id].U_id=U_id;
        rt[U_id].Per_id=Per_id;
        // rt.[U_id].len++;
    }
    
    // function getcourseByIndex(uint index) public view returns(string){
    //   //根据索引值获取课程名
    //     if(index <= sr.len){
    //         return string(sr.course[index]);
    //     }else{
    //         return "0x";
    //     }
    // }
    // function utilCompareInternal(string a, string b) public returns (bool) {
    //     if (bytes(a).length != bytes(b).length) {//比较长度
    //         return false;
    //     }
    //     for (uint i = 0; i < bytes(a).length; i ++) {//比较每一个字母
    //         if(bytes(a)[i] != bytes(b)[i]) {
    //             return false;
    //         }
    //     }
    //     return true;
    // }
    // function get_index(string U_id) public returns(uint){
    //     for (uint i=0;i<rt.len;i++){
    //         if(utilCompareInternal(string(rt.U_id[i]),U_id)){//遍历数组到我们想要的位置则返回索引值
    //             return i;
    //         }
    //     }
    //     return 0;
    // } 
    function getPer_idByU_id(string memory U_id) public view returns(uint){
      //根据U_id获取对应Per_id
        // bytes memory b = bytes(U_id);
        return rt[U_id].Per_id;
    }
    
    // function getidNo() public view returns(uint){
    //   //获取记录里的id数量id
    //     return rt.len;
    // }
    
    function del_U_id(string memory U_id)public{
      //删除记录
        // uint index=get_index(U_id);//获取索引
        delete rt[U_id];
        // uint len = rt.len;
        // if(index >= rt.len){
        //     return;
        // }
        
        // for(uint i=index;i <rt.len-1;i++){
        //     rt.U_id[i] = rt.U_id[i+1];
        // }
        
        // rt.len--;
        // delete rt.U_id[len-1];
    }
    
    function mod_Per_id(string memory U_id, uint Per_id)public{
      //记录修改
        // uint index=get_index(U_id);//获取索引
        // if(index >= rt.len){
        //     return;
        // }
        rt[U_id].Per_id = Per_id;
        
    }
}
pragma solidity >=0.4.21;
//pragma experimental ABIEncoderV2;
import "./CEB.sol";
contract CBE{
  // uint256 constant public P_pub_x= 1671464610553337622478183269762946805966380957387454084070;
  // uint256 constant public P_pub_y= 4365832020215773122990121551991008024643727629927337079945;
  // uint256 constant public PU_x= 1950228857944603264487741291955974995384949772685733331072;//先写死
  // uint256 constant public PU_y= 4911151134510861915586896012867330230329340149307553740037;
  // uint256 constant public eU= 9366358405202028562015067117472153134491920414097055773964150263;
  // uint256 constant public Qu_x= 4247735868575322551475536680534180549840587498441270683681;
  // uint256 constant public Qu_y= 5258029363773523948061363499809692783845175811524014715561;
    struct Information{
        bool Storaged;
        // uint PublicValue;
        // uint CertHash;
        uint id;
        uint P_pub_x;
        uint P_pub_y;
        uint PU_x;//先写死
        uint PU_y;
        uint eU;
        uint Qu_x;
        uint Qu_y;
    }
    event storagelog (uint,uint,uint,uint,uint,uint,uint,uint);
    mapping(uint=>Information) InforMap; //定义hash值和结构体的映射，用hash值确定所在结构体
  // function CA_store(uint hash,uint id,uint pk,uint cap)  public payable returns(string memory){  //存储函数，onlyowner进行访问控制,函数中string需要加memory
  // if(InforMap[hash].Storaged==true)           //已经存过或已经挂起，返回失败
  // {
  //   return "FAIL";
  // }
  //    Information storage infor = InforMap[hash];      //将输入存储在链上，返回成功
  //    infor.id = id;
  //    infor.CertHash=hash;
  //    infor.CAPublicKey=cap;
  //    infor.PublicValue=pk;
  //    infor.Storaged = true;
  //    InforMap[hash]=infor;     
  //    emit storagelog(hash,id,pk,cap);            //输出记录数值日志      
  //    return "SUCCESS STORE" ;
  // }
  // function CA_store(uint hash,uint id)  public payable returns(string memory){  //存储函数，onlyowner进行访问控制,函数中string需要加memory
  // if(InforMap[hash].Storaged==true)   
  function CA_store(uint hash,uint id,uint P_pub_x,uint P_pub_y,uint PU_x,uint PU_y,uint eU,uint Qu_x,uint Qu_y)  public payable returns(string memory){  //存储函数，onlyowner进行访问控制,函数中string需要加memory
  if(InforMap[hash].Storaged==true)           //已经存过或已经挂起，返回失败
  {
    return "FAIL";
  }
    Information storage infor = InforMap[hash];      //将输入存储在链上，返回成功
    infor.id = id;
    // infor.CertHash=hash;
    // infor.CAPublicKey=cap;
    // infor.PublicValue=pk;
    infor.P_pub_x=P_pub_x;
    infor.P_pub_y=P_pub_y;
    infor.PU_x=PU_x;//先写死
    infor.PU_y=PU_y;
    infor.eU= eU;
    infor.Qu_x=Qu_x;
    infor.Qu_y=Qu_y;
    infor.Storaged = true;
    InforMap[hash]=infor;     
    emit storagelog(id,P_pub_x,P_pub_y,PU_x,PU_y,eU,Qu_x,Qu_y);            //输出记录数值日志      
    return "SUCCESS STORE" ;
  }
  // function user_store(uint hash,uint id,uint pk,uint cap)  public payable returns(string memory){  //存储函数，onlyowner进行访问控制,函数中string需要加memory
  // if(InforMap[hash].Storaged==true)           //已经存过或已经挂起，返回失败
  // {
  //   return "FAIL";
  // }
  //    Information storage infor = InforMap[hash];      //将输入存储在链上，返回成功
  //    infor.id = id;
  //    infor.CertHash=hash;
  //    infor.CAPublicKey=cap;
  //    infor.PublicValue=pk;
  //    infor.Storaged = true;
  //    infor.Qu_x=Qu_x;
  //    infor.Qu_y=Qu_y;
  //    InforMap[hash]=infor;     
  //    emit storagelog(hash,id,pk,cap);            //输出记录数值日志      
  //    return "SUCCESS STORE" ;
  // }

  function verifier(uint hash) public view returns(string memory){
    if(InforMap[hash].Storaged!=true){
      return "FAIl";
    }
    else { 
      //todo 调用ECC加法做验证
      //todo 
      Information infor=InforMap[hash];
      uint Eu=infor.eU;
      uint Pu_x=infor.PU_x;
      uint Pu_y=infor.PU_y;
      uint Ppub_x=infor.P_pub_x;
      uint Ppub_y=infor.P_pub_y;
      // //ECC乘法验证
      CEB EccFunction =new CEB();
      uint Px;
      uint Py;
      (Px,Py)=EccFunction.ecmul(Pu_x,Pu_y,Eu);
      //调用ECC加法做验证
      // uint Pxx;
      // uint Pyy;
      uint Qxx;
      uint Qyy;
      (Px,Py)=EccFunction.ecadd(Px,Py,Ppub_x,Ppub_y);
      //todo 衔接
      Qxx=infor.Qu_x;
      Qyy=infor.Qu_y;
      if(Px==Qxx&&Py==Qyy){
      return "SUCCESS";
      // return getQ(1);
      }
      else{
        return "False";
      }
    }
    }
    function getQ(uint hash)  public view returns(uint,uint){
      Information infor=InforMap[hash];
      return(infor.Qu_x,infor.Qu_y);
  }
}
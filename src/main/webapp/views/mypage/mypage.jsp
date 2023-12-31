<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<style>
#tank_head {
	background-color: #86B0F3;
}

#tank_table {
	width: 72%;
	height: 80%;
	text-align: center;
	position: absolute;
	top: 255px;
	left: 400px;
}

</style>
</head>
<body>

<jsp:include page="../side.jsp"></jsp:include>
<!-- 
<main>
		
		<div id="userImg">
			<img src="<c:url value='/resources/img/mypageimg.png'/>" alr="유저이미지" />
		</div>
	


 
		<div id="mypage">
			<table>
			<div id="userImg">
			
			</div>
			
				<tr>
					<td>이름</td>
					<td id="name"></td>
				</tr>
				<tr>
					<td>사번</td>
					<td id="employeeID"></td>
				</tr>
				<tr>
					<td>직급</td>
					<td id="rankName"></td>
				</tr>
				<tr>
					<td>부서</td>
					<td id="departmentName"></td>
				</tr>
				<tr>
					<td>직책</td>
					<td id="positionName"></td>
				</tr>
				<tr>
					<td>전화</td>
					<td id="phoneNumber"></td>
				</tr>
				<tr>
					<td>남은 연차</td>
					<td id="remainingAnnualLeave"></td>
				</tr>
			
			</table>
		</div>
		
		
		<!-- 
		<div id="remainingAnnualLeave">
			<div class="residue">
				잔여 연차 일수
				<div id="count_1"></div>
			</div>

			<div class="Annual">
				연차 사용 일수
				<div id="count_2"></div>
			</div>

			<div class="Banchacha">
				반차 사용 일수
				<div id="count_3"></div>
			</div>
		</div>
	</main>
 
       -->  
    
    
    <table>
		<thead>
		<tr>
			<th>img</th>
			<th>이름</th>
			<th>사번</th>
			<th>직급</th>
			<th>직책</th>
			<th>전화</th>
			<th>남은연차<th>
		</tr>
		</thead>
		<!-- 내용 -->
		<tbody id="list">		
		</tbody>		
	</table>
    
    
    
    <input type="button" id="usermody" OnClick="location.href ='./mypageupdate'" value="수정">    
        
        
        
        
        
        
    
</body>
<script>
listCall();


function listCall(){
	$.ajax({
		type:'get',
		url:'listCall',
		data:{},
		dataType:'json',
		success:function(data){
			console.log(data);
			if(!data.login){
				alert('로그인이 필요한 서비스 입니다.');
				location.href='./';
			}else{
				drawList(data.list);
			}		
		},
		error:function(e){
			console.log(e);
		}
	});	
}


function drawList(list){
	console.log(list);
	/*for(var i=0;i<list.length;i++){}*/
	// 배열의 값을 하나씩 빼서 함수를 실행(개별값,인덱스)
	var content = '';
	list.forEach(function(item, idx){
		content += '<tr>';
		content += '<td>'+item.+'</td>';
		content += '<td>';
		if(item.img>0){
			content += '<img src="resources/img/carrot-down.PNG" width="20px"/>';	
		}else{
			content += '<img src="resources/img/carrot-side.PNG" width="20px"/>';	
		}
		content += '</td>';
		
		content += '<td>'+item.subject+'</td>';
		content += '<td>'+item.user_name+'</td>';
		content += '<td>'+item.bHit+'</td>';
		// java.sql.Date 는 jsp 에서는 정상동작 되나 js 에서는 밀리세컨드를 반환 한다.
		// 방법 1. DTO 에서 reg_date 를 String 으로 반환하는 방법
		// content += '<td>'+item.reg_date+'</td>';
		// 방법 2. js 에서 직접 변환
		var date = new Date(item.reg_date);
		var dateStr = date.toLocaleDateString("ko-KR"); //en-US
		content += '<td>'+dateStr+'</td>';		
		content += '</tr>';
	});
	$('#list').empty();
	$('#list').append(content);
	
}













/* var userImg
var name;
var employeleeID;
var rankName;
var departmentName;
var positionName;
var phoneNumber;


var residue;
var Annual;
var Banchacha;


function myPageInfo(){
	console.log("유저 정보")
	$.ajax({
		type: 'get',
		url: 'mypage/myInfo.ajax',
		data: {},
		dataType: 'json',
		success: function(data) {
			console.log(data.myInfo);
		data.myInfo.forEach(function(item, idx) { //idx는 인덱스를 뜻한다
			userImg = item.userImg
			name = item.name;
			employeleeID = item.employeleeID;
			rankName = item.rankName;
			departmentName = item.departmentName;
			positionName = item.positionName;
			phoneNumber = item.phoneNumber;
		});
			$('#userImg').html(userImg);
			$('#name').html(name);	
			$('#employeleeID').html(employeleeID);	
			$('#rankName').html(rankName);	
			$('#departmentName').html(departmentName);	
			$('#positionName').html(positionName);	
			$('#phoneNumber').html(phoneNumber);
			
			residue = data.attendanceDraft.residue;
			Annual = data.attendanceDraft.Annual;
			Banchacha = data.attendanceDraft.Banchacha;
			$('#count_1').html(residue);
			$('#count_2').html(Annual);
			$('#count_3').html(Banchacha);
			
		},
		error: function(e){
			console.log(e);
		}
	});
	
}
 */
/*
var userImg, name, employeeID, rankName, departmentName, positionName, phoneNumber;
*/


//연차 반차 남은연차
//var residue, Annual, Banchacha;
/*
function myPageInfo() {
    console.log("유저 정보");
    $.ajax({
        type: 'GET', // Use uppercase 'GET'
        url: 'myInfo.ajax',
        dataType: 'json',
        success: function(data) {
            console.log(data.myInfo);

            data.myInfo.forEach(function(item, idx) {
                userImg = item.userImg;
                name = item.name;
                employeeID = item.employeeID; // Correct variable name
                rankName = item.rankName;
                departmentName = item.departmentName;
                positionName = item.positionName;
                phoneNumber = item.phoneNumber;
            });

            $('#userImg').html(userImg);
            $('#name').html(name);
            $('#employeeID').html(employeeID); // Correct ID
            $('#rankName').html(rankName);
            $('#departmentName').html(departmentName);
            $('#positionName').html(positionName);
            $('#phoneNumber').html(phoneNumber);

         /*    residue = data.attendanceDraft.residue;
            Annual = data.attendanceDraft.Annual;
            Banchacha = data.attendanceDraft.Banchacha;
            $('#count_1').html(residue);
            $('#count_2').html(Annual);
            $('#count_3').html(Banchacha); 
        },
        error: function(e) {
            console.log(e);
        }
    });
}*/

// Call the function when the document is ready
/*
$(document).ready(function() {
    myPageInfo();
});*/

</script>
</html>
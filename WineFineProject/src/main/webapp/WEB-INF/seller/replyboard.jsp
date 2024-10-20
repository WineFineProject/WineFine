<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../tem/css/replydetail.css">
</head>
<body>
	<div class="row" id="replyBoardList">
		<h3 class="text-center">1:1 문의게시판</h3>
		<table class="table">
			<tr>
				<td class="text-right">
					<a href="../seller/noticeInsert.do" class="btn btn-sm" style="background-color: #FCD500;">글쓰기</a>
				</td>
			</tr>
		</table>
		<table class="table table-hover">
			<tr>
				<th width=10% class="text-center">번호</th>
				<th width=35% class="text-center">제목</th>
				<th width=12% class="text-center">이름</th>
				<th width=10% class="text-center">작성일</th>
				<th width=7% class="text-center">조회수</th>
				<th width=10% class="text-center">상태</th>
			</tr>
			<tr v-for="(vo, index) in list">
				<td width=10% class="text-center">{{count-index}}</td>
				<td width=35%>{{vo.subject}}</td>
				<td width=12% class="text-center">{{vo.nickname}}</td>
				<td width=10% class="text-center">{{vo.dbday}}</td>
				<td width=7% class="text-center">{{vo.hit}}</td>
				<td width=10% class="text-center">
					<a v-if="vo.isreply==0" :href="'../seller/replyInsert.do?wrno='+vo.wrno">답변대기</a>
					<span v-if="vo.isreply==1" style="cursor: pointer;" @click="detailAnswer(vo.group_id, index)">답변완료</sapn>
				</td>
			</tr>
		</table>
		<table class="table">
			<tr>
				<td class="text-center">
					<button t class="btn btn-sm btn-danger" @click="replyList(startPage>1?curPage-1:curPage)">이전</button>
					{{curPage}} page / {{totalPage}} page
					<button type="button" class="btn btn-sm btn-danger" @click="replyList(curPage<totalPage?curPage+1:curPage)">다음</button>
				</td>
			</tr>
		</table>
		<div class="modal" :class="{ show: showModal }" @click.self="changeModal(false)">
			<div class="modal-content" style="height: 485px; width: 800px;">
				<span class="close" @click="changeModal(false)">&times;</span>
				<h3 class="text-center">답변</h3>
				<!-- <table>
					<tr>
						<th width="10%" class="text-center">닉네임</th>
						<td width="23%"><span class="form-control">{{detail.nickname}}</span></td>
						<th width="10%" class="text-center">작성일</th>
						<td width="23%"><span class="form-control">{{detail.dbday}}</span></td>
						<th width="10%" class="text-center">조회수</th>
						<td width="23%"><span class="form-control">{{detail.hit}}</span></td>
					</tr>
					<tr>
						<th width="10%" class="text-center" style="margin-top: 15px;">제목</th>
						<td colspan="5"><span class="form-control" style="margin-top: 15px;">{{detail.subject}}</span></td>
					</tr>
					<tr>
						<th width="10%" class="text-center">내용</th>
						<td colspan="5"><span style="height: 200px; margin-top: 15px;" class="form-control">{{detail.content}}</span></td>
					</tr>
				</table>
				<div style="text-align: right; margin-top: 10px;">
					<button class="btn btn-sm btn-danger" @click="updatePage()">수정</button>
					<button class="btn btn-sm btn-danger" @click="deleteAnswer(detail.wrno)">삭제</button>
				</div>
			</div> -->
				<h2 class="post-title">{{detail.subject}}</h2>
				<div class="post-meta">
					<span class="author-name">{{detail.nickname}}</span> <span class="meta-separator">|</span> <span class="post-date">{{detail.dbday}}</span> <span class="meta-separator">|</span> <span class="view-count"><i class="fas fa-eye"></i>&nbsp;{{detail.hit}}</span>
				</div>
				<div class="content-box">{{detail.content}}</div>
				<div class="button-group">
					<button type="button" class="btn btn-secondary" @click="updatePage()">수정</button>
					<button type="button" class="btn btn-danger" @click="deleteAnswer(detail.wrno)">삭제</button>
				</div>
			</div>
		</div>
		<div class="modal" :class="{ show: showModal2 }" @click.self="changeModal2(false)">
			<div class="modal-content" style="height: 600px; width: 800px;">
				<span class="close" @click="changeModal2(false)">&times;</span>
				<h3 class="text-center">답변 작성</h3>
				<div class="form-group" style="margin-top: 10px;">
					<table class="table">
						<tr>
							<th width="10%" class="text-center">질문 카테고리</th>
							<td width="90%">
								<span class="form-control">{{cnos[quest.cno]}}</span>
							</td>
						</tr>
						<tr>
							<th width="10%" class="text-center">질문 제목</th>
							<td width="90%">
								<span class="form-control">{{quest.subject}}</span>
							</td>
						</tr>
						<tr>
							<th width="10%" class="text-center">질문 내용</th>
							<td width="90%">
								<span class="form-control">{{quest.content}}</span>
							</td>
						</tr>
					</table>
					<div class="form-group" style="margin-top: 10px;">
						<label for="subject">제목</label>
						<input type="text" class="form-control" ref="subject" v-model="subject" id="subject" placeholder="제목을 입력하세요">
					</div>
					<div class="form-group" style="margin-top: 10px;">
						<label for="content">내용</label>
						<textarea class="form-control" ref="content" v-model="content" id="content" rows="5" style="resize: none;" placeholder="공지 내용을 입력하세요"></textarea>
					</div>
					<div style="margin-top: 10px;"></div>
					<div class="text-center">
						<button type="button" class="btn btn-primary" @click="sellerUpdate">등록</button>
						<input type="button" class="btn btn-secondary" value="취소" @click="updatePage()">
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
		let sellerReplyListApp=Vue.createApp({
			data(){
				return{
					list:[],
					curPage:1,
					totalPage:0,
					count:0,
					detail:{},
					content:'',
					subject:'',
					cnos:['','상품 관련', '배송 관련','서비스 관련','결제 관련','기타'],
					quest:{},
					showModal:false,
					showModal2:false
				}
			},
			methods:{
				replyList(page){
					axios.get('../replyboard/vueSellerReplyList.do', {
						params:{
							page:page
						}
					}).then(response=>{
						this.list=response.data.list
						this.curPage=response.data.curPage
						this.totalPage=response.data.totalPage
						this.count=response.data.count
					})
				},
				changeModal(check){
					this.showModal=check
				},
				changeModal2(check){
					if(check===false){
						this.detail={}
					}
					this.showModal2=check
				},
				detailAnswer(gid, index){
					axios.get("../replyboard/vueAnswerDetail.do", {
						params:{
							group_id:gid
						}
					}).then(response=>{
						this.changeModal(true)
						this.quest=this.list[index]
						this.detail=response.data
						this.subject=response.data.subject
						this.content=response.data.content
					})
				},
				deleteAnswer(wrno){
					axios.get('../replyboard/vueAnswerDelete.do', {
						params:{
							wrno:wrno
						}
					}).then(response=>{
						this.detail={}
						this.changeModal(false)
						this.replyList(this.curPage)
					})
				},
				updatePage(){
					this.showModal=!this.showModal
					this.showModal2=!this.showModal2
				},
				sellerUpdate(){
					if(this.subject===''){
						this.$refs.subject.focus()
						return
					}
					if(this.content===''){
						this.$refs.content.focus()
						return
					}
					axios.get('../replyboard/vueSellerUpdate.do', {
						params:{
							wrno:this.detail.wrno,
							content:this.content,
							subject:this.subject
						}
					}).then(response=>{
						this.changeModal2(false)
						this.replyList(1)
					})
				}
			},
			mounted(){
				this.replyList(1)
			}
		}).mount('#replyBoardList')
	</script>
</body>
</html>
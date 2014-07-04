<!doctype html>
<%@ page import="com.tracking.Account"%>
<%@ page import="com.tracking.Transaction"%>
<html>
<head>
<meta name="layout" content="planning">
<title>Home</title>
<style type="text/css">
	.message{
		width:76.25em;
	}
	
	#primaryContentContainer {
	    margin: 2em -35em;
	}
	#dialogBox {
	    background: none repeat scroll 0 0 #EFEFEF;
	    border-color: #006192;
	    border-style: outset;
	    border-width: 0.5em;
	    height: 20em;
	    margin: 6em 1em 1em 24em;
	    position: fixed;
	    visibility: hidden;
	    width: 40em;
	    padding:1em;
	    z-index: 1;
	}
	#dialogBoxHead{
		height: 11%;
	}
	#dialogBoxBody{
	    overflow:scroll;
		height: 77%;
	}
	#dialogBoxFooter{
		height: 11%;
		text-align: center;
	}
	
</style>
<g:javascript library="prototype" />
<script type="text/javascript">
	var refresh = "false"
	function toggleDialogBoxVisibility(on){
		if(on=="on"){
			document.getElementById("dialogBox").style.visibility = "visible"
		}else{
			document.getElementById("dialogBox").style.visibility = "hidden"
		}	
	}	

	function setRefresh(value){
		refresh = value
	}

	function refreshPage(){
		if(refresh == "true"){
			location.reload() 
		}
	}
	
</script>
</head>
<body>
		<div id="primaryContentContainer">
			<div id="dialogBox">
				
			</div>
				<h1>Cash Flow Calendar</h1> 
				<g:form action="cashFlowCalendar">
					Weeks <g:select name="weeks" from="${1..30}"/><g:submitButton name="submit" value="Refresh"/>
				</g:form>
				<div class="calendar">
					<div class="calendarHead">
						<div class="calendarHeadCell">
							Sunday
						</div>
						<div class="calendarHeadCell">
							Monday
						</div>
						<div class="calendarHeadCell">
							Tuesday
						</div>
						<div class="calendarHeadCell">
							Wednesday
						</div>
						<div class="calendarHeadCell">
							Thursday
						</div>
						<div class="calendarHeadCell">
							Friday
						</div>
						<div class="calendarHeadCell">
							Saturday
						</div>
					</div>
					<g:set var="backGround" value="#FFFFFF"/>
					<div class="calendarBody">
						<g:each in="${calendar}" var="calendarRow">
							<div class="calendarRow">
								<g:each in="${calendarRow}" var="calendarCell">
									<g:if test="${calendarCell.date==1}">
										<g:if test="${backGround=='#FFFFFF' }">
											<g:set var="backGround" value="#C0C0C0"/>
										</g:if>
										<g:else>
											<g:set var="backGround" value="#FFFFFF"/>
										</g:else>
									</g:if>
									<g:remoteLink controller="plannedTransaction" action="remoteList" params="[date: calendarCell.fullDate]" update="dialogBox" after="toggleDialogBoxVisibility('on')">
										<div class="calendarCell" style="background-color:${backGround}">
											<div class="calendarCellHeader">
												${calendarCell.date}
											</div>
											<g:if test="${calendarCell.income}">
												+ ${calendarCell.income}<br/>
											</g:if>
											<g:if test="${calendarCell.expense}">
												- ${calendarCell.expense}<br/>
											</g:if>
											<g:if test="${calendarCell.balance}">
												bal <g:formatNumber number="${calendarCell.balance}" type="currency" currencyCode="USD" /><br/>
											</g:if>
										</div>
									</g:remoteLink>
								</g:each>
							</div>
						</g:each>
					</div>
				</div>
			</div>
</body>
</html>
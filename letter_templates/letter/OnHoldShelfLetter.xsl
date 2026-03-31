<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="header.xsl"/>
	<xsl:include href="senderReceiver.xsl"/>
	<xsl:include href="mailReason.xsl"/>
	<xsl:include href="footer.xsl"/>
	<xsl:include href="style.xsl"/>
	<xsl:include href="recordTitle.xsl"/>
	<xsl:template match="/">
		<html>
			<xsl:attribute name="data-filename">
				<xsl:value-of select="/notification_data/general_data/letter_type"/>
			</xsl:attribute>
			<head>
				<xsl:call-template name="generalStyle"/>
			</head>
			<body>
				<xsl:attribute name="style">
					<xsl:call-template name="bodyStyleCss"/>
					<!-- style.xsl -->
				</xsl:attribute>
				<xsl:call-template name="head"/>
				<!-- header.xsl -->
				<xsl:call-template name="senderReceiver"/>
				<!-- SenderReceiver.xsl -->
				<xsl:call-template name="toWhomIsConcerned"/>
				<!-- mailReason.xsl -->
				<div class="messageArea">
					<div class="messageBody">
						<table cellspacing="0" cellpadding="5" border="0">
							<!-- THIS IS THE CHUNK FOR THE GENERIC PART OF THE MESSAGE -->
							<tr>
								The library material you recently requested has been delivered and is ready for pickup. This material may be picked up at the
								
								<xsl:choose>
									<xsl:when test="/notification_data/request/delivery_address = 'Doe Library'"> <b><font size = '4'> Main Circulation Desk</font></b>.
								</xsl:when>
									<xsl:otherwise>
										<b><font size = '4'><xsl:value-of select="/notification_data/request/delivery_address"/></font></b>.
								</xsl:otherwise>
								</xsl:choose>
								
								<br/>
								<br/>
								<div style="border:1px solid black"><i><b><u>Please Note:</u></b> You may not be able to borrow the item if you have any active fines/fees at any UC Campus.
<p>You can verify the status of your account online by logging in to your institution's library account and reviewing the Fines + Fees tab for each campus listed.</p>
</i></div>
								
								<br/>
								
								<b>Please pick this up promptly.  The item will be held for you until: <xsl:value-of select="notification_data/request/work_flow_entity/expiration_date"/>
								</b>
							</tr>
							<xsl:if test="/notification_data/request/delivery_address">
								<!-- THIS IS THE CHUNK FOR SHIELDS PICKUP WITH SPECIAL SELF SERVICE HOLD INSTRUCTIONS -->
								<xsl:choose>
									<xsl:when test="/notification_data/request/delivery_address = 'Shields Library'">
										<tr>
											<td>
												<p>The library material you recently requested is ready to be picked up at the Shields Library Hold Shelf located in the lobby. Look for your library material by your last name. Materials must be checked out at the self service kiosks or the main Circulation desk.  The material will be held for one week only. If you no longer need the library material please notify us.</p>
												<p>
													<b>If you would like it shipped to you instead, please reply with a complete off-campus shipping address for home delivery.</b>
												</p>
											</td>
										</tr>
									</xsl:when>
								</xsl:choose>
								<!-- THIS IS THE CHUNK FOR BLAISDELL SHOULD ONLY APPLY TO REQUESTS PLACED BEFORE COVID RESPONSE THEIR HOLD SHELF IS INACTIVE -->
								<xsl:choose>
									<xsl:when test="/notification_data/request/delivery_address = 'Blaisdell Medical Library'">
										<tr>
											<td>
												<p>
													<b>If you would like it shipped to you instead, please reply with a complete off-campus shipping address for home delivery.</b>
												</p>
											</td>
										</tr>
									</xsl:when>
								</xsl:choose>
								<!-- THIS IS THE CHUNK FOR CARLSON SHOULD ONLY APPLY TO REQUESTS PLACED BEFORE CARLSON CLOSED FOR COVID -->
								<xsl:choose>
									<xsl:when test="/notification_data/request/delivery_address = 'Carlson Health Sci Library'">
										<tr>
											<td>
												<p>
													<b>If you would like it shipped to you instead, please reply with a complete off-campus shipping address for home delivery.</b>
												</p>
											</td>
										</tr>
									</xsl:when>
								</xsl:choose>
								<!-- THIS IS THE CHUNK FOR RIVERSIDE WITH SPECIAL CURBSIDE PICKUP INSTRUCTIONS -->
								<!-- Removing UCR special instructions 9-3-2021 
								<xsl:choose>
									<xsl:when test="/notification_data/request/delivery_address = 'University of California Riverside - Rivera Library'">
										<tr>
											<td>
												<p>The following item, which you requested, can be picked up through <b>Contactless Curbside Delivery.</b>
												</p>
												<p>Pick up ONLY: </p>
												<ul>
													<li>At the Tomas Rivera Library Loading Dock </li>
													<li>Monday – Friday, 1:00pm – 4:30pm (no appointment needed) </li>
													<li>Call 951-827-3220 to notify library staff when you have arrived at the loading dock. If you do not have access to a cell phone during pick-up, call or email (library_circulation@ucr.edu) in advance to make special arrangements. </li>
													<li>Remain in your vehicle with your windows up and your UCR Library/R’Card ready for display </li>
													<li>Walk ups are permitted with masks and social distancing in place </li>
													<li>Library staff will place requested material in the trunk of your vehicle or on a designated table for retrieval</li>
												</ul>
											</td>
										</tr>
									</xsl:when>
								</xsl:choose>
								-->
								<!-- THIS IS THE CHUNK FOR UCLA WITH SPECIAL CURBSIDE PICKUP INSTRUCTIONS 
													
								removed 9/16/2021
								
								<xsl:choose>
									<xsl:when test="/notification_data/request/delivery_address = 'University of California Los Angeles - Young Research Library'">
										<tr>
											<td>
												<p>The following item, which you requested, can be picked up through <b>Page and Pickup Service.</b>
												</p>
												<ul>
													<li>At the covered porch outside of the Charles E. Young Research Library (YRL) </li>
													<li>Monday – Friday, 10:00am – 1:00pm (Hours are for item pickup only. No other services will be available)</li>
													<li>Your Bruincard is required for pickup, and only the patron who placed the request is eligible to retrieve the item.</li>
													<li>UCLA Library will refuse service to anyone not adhering to campus COVID-19 safety regulations. </li>
													<li>For questions about other library issues, such as bills, eligibility, etc., please email yrl-circ@library.ucla.edu . </li>
												</ul>
											</td>
										</tr>
									</xsl:when>
								</xsl:choose>
								
								-->
								<!-- THIS IS THE CHUNK FOR UCSB WITH SPECIAL CURBSIDE PICKUP INSTRUCTIONS 
								removed 9/16/2021
								
								<xsl:choose>
									<xsl:when test="/notification_data/request/delivery_address = 'University of California Santa Barbara - Main Library'">
										<tr>
											<td>
												<p>The following item, which you requested on 06/14/2021, has been pulled for you.</p>
												<p>The item can be picked up at the next available pickup time for the Main Library.</p>
												<p>For the next available time, as well as instructions for pickup, please consult our webpage at https://www.library.ucsb.edu/news/pickup-and-mailing. </p>
											</td>
										</tr>
									</xsl:when>
								</xsl:choose>
								
								-->
								<!-- THIS IS THE CHUNK FOR UCI WITH SPECIAL CURBSIDE PICKUP INSTRUCTIONS -->
								<xsl:choose>
									<xsl:when test="contains(/notification_data/request/delivery_address, 'University of California Irvine')">
										<tr>
											<td>
												<p>Visit https://www.lib.uci.edu/paging-pickup-services for your pickup options.</p>
											</td>
										</tr>
									</xsl:when>
								</xsl:choose>
								<!-- THIS IS THE CHUNK FOR UCM WITH SPECIAL CURBSIDE PICKUP INSTRUCTIONS -->
								<xsl:choose>
									<xsl:when test="contains(/notification_data/request/delivery_address, 'University of California Merced')">
										<tr>
											<td>
												<p>You can schedule a time to pick-up your items here: https://library.ucmerced.edu/use/borrowing/curbside</p>
											</td>
										</tr>
									</xsl:when>
								</xsl:choose>
							</xsl:if>
							<tr>
								<td>
									
									
									
										<a>
											<xsl:attribute name="href">
												<xsl:value-of select='concat("https://search.library.berkeley.edu/discovery/fulldisplay?docid=alma", /notification_data/request/record_display_section/id, "&amp;vid=01UCS_BER:UCB&amp;lang=en" )'/>
											</xsl:attribute>
											<xsl:call-template name="recordTitle"/>
										</a>
									
			<!--						<xsl:call-template name="recordTitle"/>   -->
									<!-- recordTitle.xsl -->
								</td>
							</tr>
						</table>
					</div>
				</div>
				<br/>
				<table>
					<!-- THIS IS THE CHUNK provides a customized contact email and/or telephone for each campus -->
					<xsl:if test="/notification_data/request/delivery_address">
						<xsl:choose>
							<xsl:when test="contains(/notification_data/request/delivery_address, 'University of California Los Angeles')">
								<tr>
									<td>Contact information for your pickup library</td>
								</tr>
								<tr>
									<td>UCLA Library Circulation</td>
								</tr>
								<tr>
									<td>yrl-circ@library.ucla.edu</td>
								</tr>
							</xsl:when>
						</xsl:choose>
						<xsl:choose>
							<xsl:when test="contains(/notification_data/request/delivery_address, 'University of California Berkeley')">
								<tr>
									<td>Contact information for your pickup library</td>
								</tr>
								<tr>
									<td>maincirc-library@berkeley.edu</td>
								</tr>
							</xsl:when>
						</xsl:choose>
						<xsl:choose>
							<xsl:when test="contains(/notification_data/request/delivery_address, 'University of California Santa Cruz')">
								<tr>
									<td>Contact information for your pickup library</td>
								</tr>
								<tr>
									<td>library@ucsc.edu</td>
								</tr>
								<tr>
									<td>831-459-5185</td>
								</tr>
							</xsl:when>
						</xsl:choose>
						<xsl:choose>
							<xsl:when test="contains(/notification_data/request/delivery_address, 'University of California San Francisco')">
								<tr>
									<td>Contact information for your pickup library</td>
								</tr>
								<tr>
									<td>UCSF Library</td>
								</tr>
								<tr>
									<td>borrowing@ucsflibrary.zendesk.com</td>
								</tr>
							</xsl:when>
						</xsl:choose>
						<xsl:choose>
							<xsl:when test="contains(/notification_data/request/delivery_address, 'University of California Merced')">
								<tr>
									<td>Contact information for your pickup library</td>
								</tr>
								<tr>
									<td>UC Merced Library</td>
								</tr>
								<tr>
									<td>209-228-4444 - library@ucmerced.edu</td>
								</tr>
							</xsl:when>
						</xsl:choose>
						<xsl:choose>
							<xsl:when test="contains(/notification_data/request/delivery_address, 'University of California Riverside')">
								<tr>
									<td>Contact information for your pickup library</td>
								</tr>
								<tr>
									<td>UCR Library Circulation Services</td>
								</tr>
								<tr>
									<td>library_circulation@ucr.edu</td>
								</tr>
							</xsl:when>
						</xsl:choose>
						<xsl:choose>
							<xsl:when test="contains(/notification_data/request/delivery_address, 'University of California Irvine')">
								<tr>
									<td>Contact information for your pickup library</td>
								</tr>
								<tr>
									<td>UCI Libraries Circulation Department</td>
								</tr>
								<tr>
									<td>circadm@uci.edu</td>
								</tr>
							</xsl:when>
						</xsl:choose>
						<xsl:choose>
							<xsl:when test="contains(/notification_data/request/delivery_address, 'University of California San Diego')">
								<tr>
									<td>Contact information for your pickup library</td>
								</tr>
								<tr>
									<td>UC San Diego Library Circulation</td>
								</tr>
								<tr>
									<td>libraryborrowing@ucsd.edu</td>
								</tr>
							</xsl:when>
						</xsl:choose>
						<xsl:choose>
							<xsl:when test="contains(/notification_data/request/delivery_address, 'University of California Santa Barbara')">
								<tr>
									<td>Contact information for your pickup library</td>
								</tr>
								<tr>
									<td>Contact us at https://www.library.ucsb.edu/services/circulation/contact</td>
								</tr>
							</xsl:when>
						</xsl:choose>
						<xsl:choose>
							<xsl:when test="contains(/notification_data/request/delivery_address, 'University of California Davis')">
								<tr>
									<td>Contact information for your pickup library</td>
								</tr>
								<tr>
									<td>UCD Library</td>
								</tr>
								<tr>
									<td>530-752-9850 -- shieldscirc@ucdavis.edu</td>
								</tr>
							</xsl:when>
						</xsl:choose>
					</xsl:if>
					<tr>
						<td>
							<br/>
							<br/>Provided from the collections at</td>
					</tr>
					<tr>
						<td>UC Berkeley Libraries</td>
					</tr>
					<tr>
						<td>maincirc-library@berkeley.edu</td>
					</tr>
					<tr>
						<td>510-643-4331</td>
					</tr>
					<tr>
						<td/>
					</tr>
					<tr>
						<td>Library Hours: http://www.lib.berkeley.edu/hours</td>
					</tr>
				</table>
				<xsl:call-template name="lastFooter"/>
				<!-- footer.xsl -->
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
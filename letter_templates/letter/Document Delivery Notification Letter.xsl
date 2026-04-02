<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="header.xsl"/>
	<xsl:include href="senderReceiver.xsl"/>
	<xsl:include href="mailReason.xsl"/>
	<xsl:include href="footer.xsl"/>
	<xsl:include href="style.xsl"/>
	<xsl:include href="recordTitle.xsl"/>
	<xsl:variable name="conta1">0</xsl:variable>
	<xsl:variable name="stepType" select="/notification_data/request/work_flow_entity/step_type"/>
	<xsl:variable name="externalRequestId" select="/notification_data/external_request_id"/>
	<xsl:variable name="externalSystem" select="/notification_data/external_system"/>
	<xsl:variable name="isDeposit" select="/notification_data/request/deposit_indicator"/>
	<xsl:variable name="isDigitalDocDelivery" select="/notification_data/digital_document_delivery"/>
	<xsl:variable name="fileUploaded" select="/notification_data/file_uploaded"/>
	<xsl:template match="/">
		<html>
			<xsl:if test="notification_data/languages/string">
				<xsl:attribute name="lang">
					<xsl:value-of select="notification_data/languages/string"/>
				</xsl:attribute>
			</xsl:if>
			<head>
				<title>
					<xsl:value-of select="notification_data/general_data/subject"/>
				</title>
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
				<div class="messageArea">
					<div class="messageBody">
						<table role='presentation' cellspacing="0" cellpadding="5" border="0">
							<tr>
								<td/>
							</tr>
							<tr>
								<td>@@your_request@@</td>
							</tr>
							<tr>
								<td/>
							</tr>
							
							<!--Article Title-->
							<xsl:if test="/notification_data/resource_sharing_request/format='DIGITAL' ">
								<xsl:if test="/notification_data/resource_sharing_request/flat_d/material_type='Article' ">
									<tr>
										<td>
											@@title@@: 
											<xsl:value-of select="/notification_data/resource_sharing_request/title"/>
										</td>
									</tr>
									<tr>
										<td>
											Item title:
												<xsl:value-of select="/notification_data/resource_sharing_request/journal_title"/>
										</td>
									</tr>
									
									
								</xsl:if>
							</xsl:if>
							
							<!--Chapter Title-->							
							<xsl:if test="/notification_data/resource_sharing_request/format='DIGITAL' ">
								<xsl:if test="/notification_data/resource_sharing_request/flat_d/material_type='Book' ">
									<tr>
										<td>
											@@title@@: 
											<xsl:value-of select="/notification_data/resource_sharing_request/flat_d/chapter"/>
										</td>
									</tr>
									<tr>
										<td>
											Item title:
												<xsl:value-of select="/notification_data/resource_sharing_request/flat_d/title"/>
										</td>
									</tr>
									
									
								</xsl:if>
							</xsl:if>
							
							
<!--							
							
							<tr>
								<td>@@title@@: <xsl:value-of select="/notification_data/resource_sharing_request/flat_d/chapter"/>
								</td>
							</tr>

							<xsl:choose>
								<xsl:when test="notification_data/incoming_request/journal_title != ''">
									<tr>
										<td>
											Item title:
												<xsl:value-of select="notification_data/incoming_request/journal_title"/>
										</td>
									</tr>
								</xsl:when>
								<xsl:otherwise>
									<tr>
										<td>Item title: 
												<xsl:value-of select="/notification_data/phys_item_display/title"/>
										</td>
									</tr>
								</xsl:otherwise>
							</xsl:choose>
-->							
							<xsl:if test="/notification_data/resource_sharing_request/flat_d/chapter_author != '' ">
								<tr>
									<td>Article/Chapter author: <xsl:value-of select="/notification_data/resource_sharing_request/flat_d/chapter_author"/>
									</td>
								</tr>
							</xsl:if>
							
							<!-- For Articles -->
							
							<xsl:if test="/notification_data/resource_sharing_request/flat_d/volume != '' ">
								<tr>
									<td>Volume: <xsl:value-of select="/notification_data/resource_sharing_request/flat_d/volume"/>
									</td>
								</tr>
							</xsl:if>
							
							<xsl:if test="/notification_data/resource_sharing_request/flat_d/issue != '' ">
								<tr>
									<td>Issue: <xsl:value-of select="/notification_data/resource_sharing_request/flat_d/issue"/>
									</td>
								</tr>
							</xsl:if>
							
							<xsl:if test="/notification_data/phys_item_display/publication_date != '' ">
								<tr>
									<td>Publication Date: <xsl:value-of select="/notification_data/phys_item_display/publication_date"/>
									</td>
								</tr>
							</xsl:if>	

							<!-- For Chapters -->
							<xsl:if test="/notification_data/resource_sharing_request/flat_d/volume_bk != '' ">
								<tr>
									<td>Volume: <xsl:value-of select="/notification_data/resource_sharing_request/flat_d/volume_bk"/>
									</td>
								</tr>
							</xsl:if>	
							
							
							
							
							<xsl:if test="/notification_data/resource_sharing_request/flat_d/pages != '' ">
								<tr>
									<td>Pages: <xsl:value-of select="/notification_data/resource_sharing_request/flat_d/pages"/>
									</td>
								</tr>
							</xsl:if>				
							
							<xsl:if test="/notification_data/resource_sharing_request/flat_d/pages_normalized != '' and /notification_data/resource_sharing_request/flat_d/pages = ''">
								<tr>
									<td>Pages: <xsl:value-of select="/notification_data/resource_sharing_request/flat_d/pages_normalized"/>
									</td>
								</tr>
							</xsl:if>

							
							
							<xsl:if test="notification_data/resource_sharing_request/flat_d/author != '' ">
								<tr>
									<td>Item author: <xsl:value-of select="/notification_data/resource_sharing_request/flat_d/author"/>
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="/notification_data/resource_sharing_request/flat_d/publisher != '' ">
								<tr>
									<td>Publisher: <xsl:value-of select="/notification_data/resource_sharing_request/flat_d/publisher"/>
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/resource_sharing_request/flat_d/isbn != '' ">
								<tr>
									<td>ISBN: <xsl:value-of select="/notification_data/resource_sharing_request/flat_d/isbn"/>
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/resource_sharing_request/flat_d/issn != '' ">
								<tr>
									<td>ISSN: <xsl:value-of select="/notification_data/resource_sharing_request/flat_d/issn"/>
									</td>
								</tr>
							</xsl:if>
							<tr>
								<td>Interlibrary Loan Request ID: <xsl:value-of select="notification_data/external_request_id"/>
								</td>
							</tr>
							<xsl:if test="((notification_data/download_url_local != '' ) or (notification_data/download_url_saml != '') or (notification_data/download_url_cas != ''))">
								<tr>
									<td/>
								</tr>
								<tr>
									<td><b>@@to_see_the_resource@@</b></td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/download_url_cas != ''">
								<tr>
									<td>&#160;&#160;&#160;&#160;&#160;For <a>
											<xsl:attribute name="href">
												<xsl:value-of select="notification_data/download_url_cas"/>
											</xsl:attribute>@@for_cas_users@@</a>
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/download_url_local != ''">
								<tr>
									<td>&#160;&#160;&#160;&#160;&#160;For <a>
											<xsl:attribute name="href">
												<xsl:value-of select="notification_data/download_url_local"/>
											</xsl:attribute>@@for_local_users@@</a>
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/download_url_saml != ''">
								<tr>
									<td>&#160;&#160;&#160;&#160;&#160;For <a>
											<xsl:attribute name="href">
												<xsl:value-of select="notification_data/download_url_saml"/>
											</xsl:attribute>@@for_saml_users@@</a>
									</td>
								</tr>
							</xsl:if>
							<xsl:choose>
								<xsl:when test="notification_data/borrowing_document_delivery_max_num_of_views != ''">
									<tr>
										<td/>
									</tr>
									<tr>
										<td>Please note the following time constraints:</td>
									</tr>
									<tr>
										<td>@@max_num_of_views@@ <!-- <xsl:value-of select="notification_data/borrowing_document_delivery_max_num_of_views"/>.-->
										</td>
									</tr>
								</xsl:when>
								<xsl:when test="(notification_data/request/document_delivery_max_num_of_views != '') and ((notification_data/download_url_local != '' ) or (notification_data/download_url_saml != '') or (notification_data/download_url_cas != ''))">
									<tr>
										<td>Please note the following time constraints:</td>
									</tr>
									<tr>
										<td>@@max_num_of_views@@ <!--<xsl:value-of select="notification_data/request/document_delivery_max_num_of_views"/>.-->
										</td>
									</tr>
								</xsl:when>
							</xsl:choose>
							<xsl:if test="/notification_data/url_list/string">
								<tr>
									<td>@@attached_are_the_urls@@:</td>
								</tr>
								<xsl:for-each select="/notification_data/url_list/string">
									<tr>
										<td>
											<a>
												<xsl:attribute name="href">
													<xsl:value-of select="."/>
												</xsl:attribute>
												<xsl:value-of select="."/>
											</a>
										</td>
									</tr>
								</xsl:for-each>
							</xsl:if>
							<tr>
								<td/>
							</tr>
							<tr>
								<td>If you have any questions or concerns about what you have received, please reach out to us directly at: cuy-library@berkeley.edu</td>
							</tr>
							<tr>
								<td/>
							</tr>
							<tr>
								<td>@@sincerely@@<br/>
								</td>
							</tr>
							<tr>
								<td/>
							</tr>
							<tr>
								<xsl:choose>
									<xsl:when test="/notification_data/organization_unit/name = 'Systemwide Library Facility - North (SLF-N)' ">
										<td>
											
												Systemwide Library Facility - North (SLF-N)
											
										</td>
										<tr>
											<td>
												
													510-665-6738
												
											</td>
										</tr>
									</xsl:when>
									<xsl:otherwise>
										<td>		
											
												Borrowing Services
											
											
										</td>
										<tr>
											<td>
												cuy-library@berkeley.edu
											</td>
										</tr>
										<tr>
											<td>
												510-642-7365
												
											</td>
										</tr>
									</xsl:otherwise>
								</xsl:choose>
							</tr>
							<tr>
								<td>
												
												
											</td>
							</tr>
							<tr>
								<td>
												Library Hours: http://www.lib.berkeley.edu/hours
												
											</td>
							</tr>
						</table>
					</div>
				</div>
				<xsl:call-template name="lastFooter"/>
				<!-- footer.xsl -->
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>

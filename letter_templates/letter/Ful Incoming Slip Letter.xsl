<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:variable name="counter" select="0"/>


<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />
<xsl:include href="recordTitle.xsl" />

<xsl:template name="id-info">
   <xsl:param name="line"/>
   <xsl:variable name="first" select="substring-before($line,'//')"/>
   <xsl:variable name="rest" select="substring-after($line,'//')"/>
    <xsl:if test="$first = '' and $rest = '' ">
          <!--br/-->
      </xsl:if>
   <xsl:if test="$rest != ''">
       <xsl:value-of select="$rest"/><br/>
   </xsl:if>
   <xsl:if test="$rest = ''">
       <xsl:value-of select="$line"/><br/>
   </xsl:if>

</xsl:template>

  <xsl:template name="id-info-hdr">
        <xsl:call-template name="id-info">
            <xsl:with-param name="line" select="notification_data/incoming_request/external_request_id"/>
            <xsl:with-param name="label" select="'Bibliographic Information:'"/>
         </xsl:call-template>
</xsl:template>

<xsl:template match="/">
	<html>
		<head>
		<xsl:call-template name="generalStyle" />
		</head>

			<body>
			<xsl:attribute name="style">
				<xsl:call-template name="bodyStyleCss" /> <!-- style.xsl -->
			</xsl:attribute>

				<xsl:call-template name="head" /> <!-- header.xsl -->



			<div class="messageArea">
				<div class="messageBody">
					 <table cellspacing="0" cellpadding="5" border="0">


						<tr>
							<td>
								<b>@@supplied_to@@: </b>
								<xsl:choose>
									<xsl:when test="notification_data/incoming_request/pickup_partner_name != ''">
										<xsl:value-of select="notification_data/incoming_request/pickup_partner_name"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="notification_data/partner_name"/>
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>


						<tr>
			                <td>
			                  <b>@@borrower_reference@@: </b>
			                   <xsl:call-template name="id-info-hdr"/>
			                </td>
			              </tr>

						<xsl:if  test="notification_data/incoming_request/requested_barcode" >
							<tr>
								<td>
									<b>RapidILL Reference Barcode: </b>
									<xsl:value-of select="notification_data/incoming_request/requested_barcode"/>
								</td>
							</tr>
						</xsl:if>


			          <tr>
							  <td><b>@@my_id@@: </b><img src="externalId.png" alt="externalId" /></td>
				      </tr>

						<tr>
							<td>
								<b>@@format@@: </b>
								<xsl:value-of select="notification_data/incoming_request/format"/>
							</td>
							<td>
									<b>@@date_needed_by@@: </b>
									<xsl:value-of select="notification_data/incoming_request/needed_by"/>
								</td>
						</tr>
<!--
						<xsl:if  test="notification_data/incoming_request/needed_by_dummy/full_date" >
							<tr>
								<td>
									<b>@@date_needed_by@@: </b>
									<xsl:value-of select="notification_data/incoming_request/needed_by"/>
								</td>
							</tr>
						</xsl:if>
-->
						<xsl:if  test="notification_data/incoming_request/note" >
							<tr>
								<td>
									<b>@@request_note@@: </b>
									<xsl:value-of select="notification_data/incoming_request/note"/>
								</td>
							</tr>
						</xsl:if>

						<xsl:if  test="notification_data/incoming_request/requester_email" >
							<tr>
								<td>
									<b>@@requester_email@@: </b>
									<xsl:value-of select="notification_data/incoming_request/requester_email"/>
								</td>
							</tr>
						</xsl:if>

						<xsl:if  test="/notification_data/incoming_request/create_date_with_time_str" >
							<tr>
								<td>
									<b>Created: </b>
									<xsl:value-of select="/notification_data/incoming_request/create_date_with_time_str"/>
								</td>
							</tr>
						</xsl:if>
				
						<!--Book Title-->
<!--						<xsl:if test="notification_data/incoming_request/format='PHYSICAL' ">  -->
							<tr>
								<td>
									<b>Title: </b>
									<xsl:choose>
										<xsl:when test="notification_data/incoming_request/journal_title != ''">
											<xsl:value-of select="notification_data/incoming_request/journal_title"/>
										</xsl:when>
									<xsl:otherwise>
											<xsl:value-of select="substring(notification_data/metadata/title, 1, 100)"/>
										</xsl:otherwise>
									</xsl:choose>
								</td>
							</tr>
<!--						</xsl:if>   -->
						
						<!--Article Title-->
						<tr>
							<td><b>Chapter:&#160;</b>
						<xsl:if test="notification_data/incoming_request/format='DIGITAL' ">
							<xsl:if test="notification_data/metadata/material_type='Article' ">
						
								<xsl:if test="notification_data/metadata/journal_title">
                                    
                                       
                                          
                                          <xsl:text />
                                          <xsl:value-of select="substring(notification_data/metadata/journal_title, 1, 100)" />
                                       
                                    
                                 </xsl:if>
                                 <xsl:if test="notification_data/metadata/normalized_title">
                             <!--       <tr>
                                       <td>
                                          <b>Chapter:&#160;</b>  -->
                                          <xsl:text />
                                          <xsl:value-of select="substring(notification_data/metadata/normalized_title, 1, 100)" />
                                   <!--    </td>
                                    </tr>    -->
                                 </xsl:if>
							</xsl:if>
						</xsl:if>
							</td>
						</tr>
						 <!--Article Author-->
                        <xsl:if test="notification_data/incoming_request/format='DIGITAL' ">
                           <xsl:if test="notification_data/metadata/material_type='Article' ">
						
						         <tr>
                                    <td>
                                       <b>Author:&#160;</b>
                                       <xsl:value-of select="substring(notification_data/metadata/author, 1, 100)" />
                                    </td>
                                 </tr>
                                 
							</xsl:if>
						</xsl:if>
						
						<!--Chapter Author-->
						
						<xsl:if test="notification_data/metadata/material_type='Book' ">
                            <xsl:if test="notification_data/partner_name">
									
								<xsl:if test="not(notification_data/metadata/chapter_author='')">
									<tr>
                                       <td>
                                          <b>Author:&#160;</b>
                                          <xsl:text />
                                          <xsl:value-of select="substring(notification_data/metadata/chapter_author, 1, 100)" />
                                       </td>
                                    </tr>
                                 </xsl:if>
							</xsl:if>
						</xsl:if>
						
						<xsl:if  test="/notification_data/metadata/volume" >
							<tr>
								<td>
									<b>@@volume@@: </b>
									<xsl:value-of select="/notification_data/metadata/volume"/>
								</td>
								<td>
                                    <b>@@issue@@:&#160;</b>
                                    <xsl:text />
                                    <xsl:value-of select="notification_data/metadata/issue" />
                                </td>
							</tr>
						</xsl:if>
<!--						
						<xsl:if test="notification_data/metadata/issue">
                            <tr>
                                <td>
                                    <b>@@issue@@:&#160;</b>
                                    <xsl:text />
                                    <xsl:value-of select="notification_data/metadata/issue" />
                                </td>
                            </tr>
                        </xsl:if>
-->						
                        <xsl:if test="notification_data/metadata/publication_date">
                            <tr>
                                <td>
                                    <b>@@publication_date@@:&#160;</b>
                                    <xsl:text />
                                    <xsl:value-of select="notification_data/metadata/publication_date" />
                                </td>
                           </tr>
                        </xsl:if>						

                        <xsl:if test="notification_data/metadata/publisher">
                            <tr>
                                <td>
                                    <b>@@publisher@@:&#160;</b>
                                    <xsl:text />
                                    <xsl:value-of select="notification_data/metadata/publisher" />
                                </td>
                           </tr>
                        </xsl:if>						
						
						<xsl:if test="/notification_data/metadata/isbn != '' ">
							<tr>
								<td><b>ISSN/ISBN: </b> <xsl:value-of select="/notification_data/metadata/isbn"/></td>
								<td>
                                    <b>@@oclc_number@@:&#160;</b>
                                    <xsl:text />
                                    <xsl:value-of select="/notification_data/metadata/oclc_number" />
                                </td>	
							</tr>
						</xsl:if>												
							
						<xsl:if test="/notification_data/metadata/issn != '' ">
							<tr>
								<td><b>ISSN/ISBN: </b> <xsl:value-of select="/notification_data/metadata/issn"/></td>
								<td>
                                    <b>@@oclc_number@@:&#160;</b>
                                    <xsl:text />
                                    <xsl:value-of select="/notification_data/metadata/oclc_number" />
                                </td>		
							
							</tr>
				
						
						
						</xsl:if>						
<!--						
						<xsl:if test="/notification_data/metadata/oclc_number">
                            <tr>
                                <td>
                                    <b>@@oclc_number@@:&#160;</b>
                                    <xsl:text />
                                    <xsl:value-of select="/notification_data/metadata/oclc_number" />
                                </td>
                           </tr>
                        </xsl:if>		
-->
							<tr>
								<td><b>@@library@@: </b><xsl:value-of select="location_name"/></td>
							</tr>

							<xsl:if  test="/notification_data/metadata/call_number" >
								<tr>
									<td><b>@@call_number@@: </b><xsl:value-of select="/notification_data/metadata/call_number"/></td>
									   <td>
                                          <b>@@pages@@:&#160;</b>
                                          <xsl:text />
                                          <xsl:value-of select="notification_data/metadata/pages" />
                                       </td>
								</tr>
							</xsl:if>

							<xsl:if  test="shelving_location/string" >
								<tr>
									<td><b>@@shelving_location_for_item@@: </b>
									 <xsl:for-each select="shelving_location/string">
										<xsl:value-of select="."/>
									 &#160;
									 </xsl:for-each>
									</td>
								</tr>
							</xsl:if>

						
<!--
						<xsl:if  test="notification_data/assignee" >
							<tr>
								<td>
									<b>@@assignee@@: </b>
									<xsl:value-of select="notification_data/assignee"/>
								</td>
							</tr>
						</xsl:if>

								<xsl:if test="notification_data/level_of_service">
									<tr>
										<td>
											<b>@@level_of_service@@: </b>
											<xsl:value-of select="notification_data/level_of_service"/>
										</td>

									</tr>
								</xsl:if>
-->

<!--						<xsl:for-each select="notification_data/items/physical_item_display_for_printing">    
							<br></br>  
-->
<!--
                                 <xsl:if test="notification_data/metadata/pages">
                                    <tr>
                                       <td>
                                          <b>@@pages@@:&#160;</b>
                                          <xsl:text />
                                          <xsl:value-of select="notification_data/metadata/pages" />
                                       </td>
                                    </tr>
                                 </xsl:if>
-->

							<tr>
							  <td><b>@@item_barcode@@: </b><img src="cid:{concat(concat('Barcode',position()),'.png')}" alt="{concat('Barcode',position())}" /></td>
							</tr>
<!--
							<tr>
								<td><xsl:value-of select="title"/></td>
							</tr>
-->
                            <tr>
                                 <td>
                                    <b>Resource Sharing Request ID: </b><img src="cid:resource_sharing_request_id.png" />
                                 </td>
                            </tr>

<!--
							<tr>
								<td>
									<b>@@library@@: </b>
									<xsl:value-of select="library_name"/>
								</td>
							</tr>
-->

<!--						</xsl:for-each>    -->
						
						<tr><td/></tr>
						<tr>
							<td>Please contact us directly by email if you have any questions or problems accessing the file at: lending-library@berkeley.edu</td>
						</tr>
						
						<tr><td/></tr>
						<tr><td/></tr>
						
						<tr><td>Lending Services Department</td></tr>
						<tr><td>Resource Sharing Division</td></tr>
						<tr><td>UC Berkeley Library - CUY</td></tr>
						
						
					</table>
				</div>
			</div>




	<xsl:call-template name="lastFooter" /> <!-- footer.xsl -->





</body>
</html>


	</xsl:template>
</xsl:stylesheet>

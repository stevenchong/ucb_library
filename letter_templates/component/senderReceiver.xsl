<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template name="senderReceiver">
		<table cellspacing="0" cellpadding="5" border="0" width="100%">
			<tr>
				<td width="50%">
					<xsl:choose>
						<xsl:when test="notification_data/user_for_printing">
							<table cellspacing="0" cellpadding="5" border="0">
								<xsl:attribute name="style"> 
									<xsl:call-template name="listStyleCss"/>
									<!-- style.xsl -->
								</xsl:attribute>
								<xsl:choose>
									<xsl:when test="/notification_data/receivers/receiver/user/preferred_first_name and not(/notification_data/receivers/receiver/user/preferred_first_name = '') and /notification_data/receivers/receiver/user/preferred_last_name and not(/notification_data/receivers/receiver/user/preferred_last_name = '')">
										<tr>
											<td>
												<b>
													<xsl:value-of select="/notification_data/receivers/receiver/user/preferred_first_name"/>&#160;<xsl:value-of select="/notification_data/receivers/receiver/user/preferred_last_name"/>
												</b>
											</td>
										</tr>
									</xsl:when>
									<xsl:when test="/notification_data/receivers/receiver/user/first_name and not(/notification_data/receivers/receiver/user/first_name = '') and /notification_data/receivers/receiver/user/last_name and not(/notification_data/receivers/receiver/user/last_name = '')">
										<tr>
											<td>
												<b>
													<xsl:value-of select="/notification_data/receivers/receiver/user/first_name"/>&#160;<xsl:value-of select="/notification_data/receivers/receiver/user/last_name"/>
												</b>
											</td>
										</tr>
									</xsl:when>
									<xsl:otherwise>
										<tr>
											<td>
												<b>
													<xsl:value-of select="notification_data/user_for_printing/first_name"/>&#160;<xsl:value-of select="notification_data/user_for_printing/last_name"/>
												</b>
											</td>
										</tr>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:if test="not(/notification_data/user_for_printing/address1 = '')">
								
									<tr>
										<td>
											<xsl:value-of select="notification_data/user_for_printing/address1"/>
										</td>
									</tr>
								</xsl:if>	
									
								<xsl:if test="not(/notification_data/user_for_printing/address2 = '')">	
									<tr>
										<td>
											<xsl:value-of select="notification_data/user_for_printing/address2"/>
										</td>
									</tr>
								</xsl:if>	
								
								<xsl:if test="not(/notification_data/user_for_printing/address3 = '')">	
									<tr>
										<td>
											<xsl:value-of select="notification_data/user_for_printing/address3"/>
										</td>
									</tr>
								</xsl:if>	
								
								<xsl:if test="not(/notification_data/user_for_printing/address4 = '')">									
									<tr>
										<td>
											<xsl:value-of select="notification_data/user_for_printing/address4"/>
										</td>
									</tr>
								</xsl:if>
								
								<xsl:if test="not(/notification_data/user_for_printing/address5 = '')">	
									<tr>
										<td>
											<xsl:value-of select="notification_data/user_for_printing/address5"/>
										</td>
									</tr>
								</xsl:if>
								
								<xsl:if test="(/notification_data/user_for_printing/address2 = '') and (/notification_data/user_for_printing/address3 = '') and (/notification_data/user_for_printing/address4 = '') and (/notification_data/user_for_printing/address5 = '')">
								
									<xsl:if test="not(/notification_data/user_for_printing/city = '')" >
									
										<tr>
											<td>
												<xsl:value-of select="notification_data/user_for_printing/city"/>,&#160;<xsl:value-of select="notification_data/user_for_printing/state"/>&#160;<xsl:value-of select="notification_data/user_for_printing/postal_code"/>
											</td>
										</tr>
									
									</xsl:if>
													
									<tr>
										<td>
											<xsl:value-of select="notification_data/user_for_printing/country"/>
										</td>
									</tr>
								</xsl:if>
								
							</table>
						</xsl:when>
						<xsl:when test="notification_data/receivers/receiver/user">
							<xsl:for-each select="notification_data/receivers/receiver/user">
								<table>
									<xsl:attribute name="style">
										<xsl:call-template name="listStyleCss"/>
										<!-- style.xsl -->
									</xsl:attribute>
									<xsl:choose>
										<xsl:when test="preferred_first_name and not(preferred_first_name = '') and preferred_last_name and not(preferred_last_name = '')">
											<tr>
												<td>
													<b>
														<xsl:value-of select="preferred_first_name"/>&#160;<xsl:value-of select="preferred_last_name"/>
													</b>
												</td>
											</tr>
										</xsl:when>
										<xsl:otherwise>
											<tr>
												<td>
													<b>
														<xsl:value-of select="last_name"/>&#160;<xsl:value-of select="first_name"/>
													</b>
												</td>
											</tr>
										</xsl:otherwise>
									</xsl:choose>
									<tr>
										<td>
											<xsl:value-of select="user_address_list/user_address/line1"/>
										</td>
									</tr>
									<tr>
										<td>
											<xsl:value-of select="user_address_list/user_address/line2"/>
										</td>
									</tr>
									<tr>
										<td>
											<xsl:value-of select="user_address_list/user_address/city"/>&#160;<xsl:value-of select="user_address_list/user_address/postal_code"/>
										</td>
									</tr>
									<tr>
										<td>
											<xsl:value-of select="user_address_list/user_address/state_province"/>&#160;<xsl:value-of select="user_address_list/user_address/country"/>
										</td>
									</tr>
								</table>
							</xsl:for-each>
						</xsl:when>
						<xsl:otherwise>

		</xsl:otherwise>
					</xsl:choose>
				</td>
				<td width="40%" align="left">
					<xsl:for-each select="notification_data/organization_unit">
						<table>
							<xsl:attribute name="style">
								<xsl:call-template name="listStyleCss"/>
								<!-- style.xsl -->
							</xsl:attribute>
							
							<xsl:if test="not(/notification_data/general_data/letter_name = 'On Hold Shelf Letter')">	

							    <tr>
								    <td>
									    <xsl:value-of select="name"/>
								    </td>
							    </tr>
							  
							    
							    <xsl:choose>
								    <xsl:when test="not(name = address/line1)">
									    <tr>
										    <td>
											    <xsl:value-of select="address/line1"/>
							    			</td>
								    	</tr>
								    </xsl:when>
							    </xsl:choose>
							    <tr>
								    <td>
								    	<xsl:value-of select="address/line2"/>
							    	</td>
							    </tr>
							    <tr>
								    <td>
									    <xsl:value-of select="address/city"/>
								    </td>
							    </tr>
							    <tr>
								    <td>
									    <xsl:value-of select="address/postal_code"/>
			    					</td>
				    			</tr>
					    		<tr>
						    		<td>
							    		<xsl:value-of select="address/country"/>
							    	</td>
						    	</tr>
							</xsl:if>  
							
						</table>
					</xsl:for-each>
				</td>
			</tr>
		</table>
	</xsl:template>
</xsl:stylesheet>
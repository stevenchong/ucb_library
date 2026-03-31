<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:template name="recordTitle">
			<p/>
			<div class="recordTitle">
				<span class="spacer_after_1em">&#160;&#160;<b>Title: </b>  <xsl:value-of select="notification_data/phys_item_display/title"/></span>
			</div>
			<p/>
			<xsl:if test="notification_data/phys_item_display/author !=''">
				<div class="">
					<span class="spacer_after_1em">
						<span class="recordAuthor">&#160;&#160;<b>@@by@@ </b> <xsl:value-of select="notification_data/phys_item_display/author"/></span>
					</span>
				</div>
			</xsl:if>
			<p/>
			<xsl:if test="notification_data/phys_item_display/issue_level_description !=''">
			
			<xsl:if test="not(contains(notification_data/request/calculated_destination_name, 'Digitization Department')) and not(/notification_data/general_data/letter_name = 'Transit Letter' or 'Resource Request Slip Letter') and not(contains(notification_data/request/calculated_destination_name, 'Digitization Department'))">
				<div class="">
					<span class="spacer_after_1em">
						<span class="volumeIssue">&#160;&#160;<b>@@description@@ </b><xsl:value-of select="notification_data/phys_item_display/issue_level_description"/></span>
					</span>
				</div>
				</xsl:if>
			</xsl:if>
			
<!--			<xsl:if test="/notification_data/phys_item_display/call_number !='' or /notification_data/general_data/letter_name != 'Hold Shelf Request Slip Letter' or /notification_data/general_data/letter_name != 'Resource Request Slip Letter' or /notification_data/general_data/letter_name != 'Transit Letter'" > -->
			<p/>
			<xsl:if test="/notification_data/phys_item_display/call_number !='' and /notification_data/general_data/letter_name != ('Hold Shelf Request Slip Letter' or 'Resource Request Slip Letter' or 'Transit Letter')" >
			

			<div class="">
					<span class="spacer_after_1em">
						<span class="volumeIssue">&#160;&#160;<b>Call Number: </b><xsl:value-of select="/notification_data/phys_item_display/call_number"/></span>
					</span>
				</div>
			</xsl:if>
			<p/>
			<xsl:if test="/notification_data/phys_item_display/barcode !=''">
				<div class="">
					<span class="spacer_after_1em">
						<span class="volumeIssue">&#160;&#160;<b>Barcode: </b><xsl:value-of select="/notification_data/phys_item_display/barcode"/></span>
					</span>
				</div>
			</xsl:if>
			

</xsl:template>

</xsl:stylesheet>
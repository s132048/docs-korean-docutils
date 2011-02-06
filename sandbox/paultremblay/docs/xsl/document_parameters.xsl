<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    version="1.1">

    <!-- $Id$ -->

    <xsl:include href="comment.xsl"/>
    <xsl:include href="utils.xsl"/>

    <xsl:output method="xml"/>

    <xsl:template match="xsl:stylesheet">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="/">
        <doc>
            <xsl:call-template name="make-title">
                <xsl:with-param name="level">1</xsl:with-param>
                <xsl:with-param name="text">XSL-FO Documentation</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="make-title">
                <xsl:with-param name="level">2</xsl:with-param>
                <xsl:with-param name="text">Parameters</xsl:with-param>
            </xsl:call-template>
            <block>.. contents:: Table of Contents</block>
            <xsl:apply-templates/>
        </doc>
    </xsl:template>

    <xsl:template match="xsl:param[@name='page-layout']" priority = "3">
        <xsl:call-template name="before_p_text">
            <xsl:with-param name="possible-values">
                <xsl:text>simple, first, odd-even, first-odd-even</xsl:text>
            </xsl:with-param>
        </xsl:call-template>
        <block>
            This parameter determines the page layout for the document. A value of
            ``simple`` will create a document with the same page layout for all 
            pages. A value of ``first`` creates a document with a dfferent page
            layout for the first page and for the rest of the pages. A value of
            ``odd-even`` creates a different layout for for odd and even pages. A value
            of ``first-odd-even`` creates a different layout for the first page, for
            odd pages, and for even pages.
        </block>
        <block>
            Because restructured text only allows one footer and header, the footer and header
            will be the same for bth odd and even pages. However, if the ``first`` or
            ``first-odd-even`` values is chosen, you can suppress the first footer and 
            header (see below).
        </block>
        <block>
            Using a value other than ``simple`` allows for different margins for different
            page sequences, depending on the value.
        </block>
    </xsl:template>

    <xsl:template match="xsl:param[@name='suppress-first-page-header']" priority = "3">
        <xsl:call-template name="before_p_text">
            <xsl:with-param name="possible-values">
                <xsl:text>True, False, ''</xsl:text>
            </xsl:with-param>
        </xsl:call-template>
        <block>
            If set to True, and the ``page-layout`` is set to``first``, or ``page-layout``
            is set to ``first-odd-even``, no header will appear on the first page. If a value
            of ``simple`` or ``odd-even`` is chosen for the ``page-layout``, this parameter will
            have no effect, and the header will appear on all pages.
        </block>
    </xsl:template>

    <xsl:template match="xsl:param[@name='suppress-first-page-footer']" priority = "3">
        <xsl:call-template name="before_p_text">
            <xsl:with-param name="possible-values">
                <xsl:text>True, False, ''</xsl:text>
            </xsl:with-param>
        </xsl:call-template>
        <block>
            If set to True, and the ``page-layout`` is set to ``first``, or ``page-layout``
            is set to ``first-odd-even``, no footer will appear on the first page. If a value
            of ``simple`` or ``odd-even`` is chosen for the ``page-layout``, this parameter will
            have no effect, and the footer will appear on all pages.
        </block>
    </xsl:template>


    <xsl:template match="xsl:param[@name='spacing-header']" priority = "3">
        <xsl:call-template name="make-name">
            <xsl:with-param name="name">spacing-header and spacing-footer</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="possible-values">
            <xsl:with-param name="text" select="'Any Measure'"/>
        </xsl:call-template>
        <xsl:call-template name="p-defaults"/>
        <block>
            The parameters ``spacing-header`` and ``spacing-footer`` create the space for the 
            header and footer. Although the default is set to an empty string, the XSL
            styelsheets will create a satisfactory space if a header or footer is found. Use
            either of these parameters to change that default.
        </block>
    </xsl:template>

    <xsl:template match="xsl:param[@name='spacing-footer']" priority = "3"/>

    <xsl:template match="xsl:param[@name='title-pagination']" priority = "3">
        <xsl:call-template name="make-name">
            <xsl:with-param name="name">pagination for front matter</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="possible-values">
            <xsl:with-param name="text" select="'with-front, with-toc, with-body'"/>
        </xsl:call-template>
        <block>**Defaults:** See below</block>
        <block>
            The function is the same for the following parameters:
        </block>
        <block>* title-pagination</block>
        <block>* bibliographic-pagination</block>
        <block>* dedication-pagination</block>
        <block>* abstract-pagination</block>
        <block>* toc-pagination</block>
        <block>
            Each determines what region to place the textual matter. There are 
            three regions, the front matter, the toc matter, and the body matter. The front 
            matter has no footers and headers. The toc matter starts a new page run, in which 
            the numbers start with 1 (or any other value), and can take any formatting. The 
            body matter again starts a new run of pages with its own page numbering and formatting
            of these numbers.
        </block>
        <block>
            In practice, the abstract and title page often occurr before the other front matter 
            material, and they appear on pages with no footers and headers. The dedication and Table
            of Contents appear next, with the first numbering of the document, the numbers being
            formatted as lower-case Roman numberals. The bibliographic information could appear 
            in either the front matter or toc matter. In order to achieve this standard layout,
            the defaults choose a ``with-front`` for the ``title-pagination``, 
            ``abstract-pagination.``, and ``bibliographic-pagination; and a 
            ``with-toc`` for the ``toc-pagination`` and ``dedication-pagination``.
        </block>
        <block>
            In order to change these defaults, choose a different value. For example, 
            to place the dedication in the front matter, set ``dedication-pagination`` to
            ``with-front``. For a simple document, in which there is only one set of page runs, 
            simply set each of these parameters to ``with-body``.
            
        </block>
    </xsl:template>


    <xsl:template match="xsl:param[@name='bibliographic-pagination']|
            xsl:param[@name='dedication-pagination']| xsl:param[@name='abstract-pagination']|
                xsl:param[@name='toc-pagination'] " priority = "3"/>

    <xsl:template match="xsl:param[@name='front-order']" priority = "3">
        <xsl:call-template name="before_p_text">
            <xsl:with-param name="possible-values">
                <xsl:text>title,bibliographic,dedication,abstract,toc</xsl:text>
            </xsl:with-param>
        </xsl:call-template>
        <block>
            The param ``front-order`` is a string of each region, separated by a comma, 
            that determines the order of the title, the bibliographic
            information, the dedication, the abstract, and the Table of Contents. The 
            default puts them in order that docutils puts them in when the document is
            converted to XML. In order to change this, change the order in the string.
            For example, to place the abstract before the dedication, use
            ``'title,bibliographic,dedication,abstract,toc'`` as a value.
        </block>
        <block>
            If you have a region in your parameter value that does not actually exist 
            in your document, no error will occurr. For example, if you set your value
            to ``title,bibliographic,dedication,abstract,toc``, but have no ``title`` in 
            your document, the XSL stylesheet will still place the abstract before the dedication
            without raising any error.
        </block>
        <block>
            However, if you lack a region in your value that exists in the document, the 
            stylesheets will recognize this as an error, notifiy you, and quit. For eaxmple, 
            if your value is ``,bibliographic,dedication,abstract,toc``, and your document 
            contains a title, the processing will quit.
        </block>
    </xsl:template>

    <xsl:template match="xsl:param[@name='author-text']" priority = "3">
        <xsl:call-template name="make-name">
            <xsl:with-param name="name">Bibliographic Field Names</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="possible-values">
            <xsl:with-param name="text" select="'Any Text'"/>
        </xsl:call-template>
        <block>**Defaults:** See below</block>
        <block>
            The function is the same for the following parameters:
        </block>
        <block>* author-text (default: Author: )</block>
        <block>* authors-text (default: Authors: )</block>
        <block>* organization-text (default: Organization: )</block>
        <block>* contact-text (default: Contact: )</block>
        <block>* status-text (default: Status: )</block>
        <block>* copyright-text (default: Copyright: )</block>
        <block>* address-text (default: Address: )</block>
        <block>* version-text (default: Version: )</block>
        <block>* revision-text (default: Revison: )</block>
        <block>* date-text (default: Date: )</block>
        <block>
            Each parameter sets the text in the list for that particular bibliographic item. 
            For example if you wanted to change the default for ``contact`` from 'contact' to email, 
            you would simply set this value to 'email'.
        </block>
    </xsl:template>

    <xsl:template match="xsl:param[@name='authors-text']| 
        xsl:param[@name='organization-text']| xsl:param[@name='contact-text']|
        xsl:param[@name='status-text']| xsl:param[@name='copyright-text']|
        xsl:param[@name='address-text']| xsl:param[@name='version-text']|
        xsl:param[@name='revision-text']| xsl:param[@name='date-text'] " priority = "3"/>

    <xsl:template match="xsl:param[@name='attention-title']" priority = "3">
        <xsl:call-template name="make-name">
            <xsl:with-param name="name">Admonition Title Names</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="possible-values">
            <xsl:with-param name="text" select="'Any Text'"/>
        </xsl:call-template>
        <block>**Defaults:** See below</block>
        <block>
            The function is the same for the following parameters:
        </block>
        <block>* attention-title (default: Attention!)</block>
        <block>* caution-title (default: Caution!)</block>
        <block>* danger-title (default: !Danger!)</block>
        <block>* error-title (default: Error)</block>
        <block>* hint-title (default: Hint)</block>
        <block>* important-title (default: Important)</block>
        <block>* note-title (default: Note)</block>
        <block>* tip-title (default: Tip)</block>
        <block>* warning-title (default: Warning!)</block>
        <block>
            Each parameter sets the text for the title for that particular Admonition. 
            For example if you wanted to change the default for ``attention-title`` from 
            'Important' to 'Pay Attention!', you would simply set this value to 'Pay Attnetion!'.
        </block>
    </xsl:template>

    <xsl:template match="xsl:param[@name='caution-title']| xsl:param[@name='caution-title']|
        xsl:param[@name='danger-title']| xsl:param[@name='error-title']|
        xsl:param[@name='hint-title']| xsl:param[@name='important-title']|
        xsl:param[@name='note-title']| xsl:param[@name='tip-title']|
        xsl:param[@name='warning-title']" priority = "3"/>

    <xsl:template match="xsl:param[@name='transition-text']" priority = "3">
        <xsl:call-template name="make-name">
            <xsl:with-param name="name">transition-text</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="possible-values">
            <xsl:with-param name="text" select="'Any Text'"/>
        </xsl:call-template>
        <block>**Defaults:** \*\*\*</block>
        <block>
            The text to use for a transtion element. Use any text (including an empty 
            string) to change that value.
        </block>
    </xsl:template>

    <xsl:template match="xsl:param[@name='number-section1']" priority = "3">
        <xsl:call-template name="make-name">
            <xsl:with-param name="name">Formatting of Section Numbering</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="possible-values">
            <xsl:with-param name="text" select="'Valid Number Formatting String'"/>
        </xsl:call-template>
        <block>**Defaults:** See below</block>
        <block>
            The function is the same for the following parameters:
        </block>
        <block>* number-section1 (default: 1)</block>
        <block>* number-section2 (default: .1)</block>
        <block>* number-section3 (default: .1)</block>
        <block>* number-section4 (default: .1)</block>
        <block>* number-section5 (default: .1)</block>
        <block>* number-section6 (default: .1)</block>
        <block>* number-section7 (default: .1)</block>
        <block>* number-section8 (default: .1)</block>
        <block>* number-section9 (default: .1)</block>
        <block>
            Each parameter sets the formatting (not the actual number) for that particular level.
            The stylesheets allow for a great deal of flexibility here. For example, in 
            order to set a level 3 number format to '(II)3.b', you would set 
            ``number-section1`` to '(I)', ``number-section2`` to '.1' (the default, in this case,
            meaning you woud not need to make a change), and ``number-section3`` to
            '.a'. 
        </block>
    </xsl:template>

    <xsl:template match="xsl:param[@name='number-section2']| xsl:param[@name='number-section3']|
        xsl:param[@name='number-section4']| xsl:param[@name='number-section5']|
        xsl:param[@name='number-section6']| xsl:param[@name='number-section7']|
        xsl:param[@name='number-section8']| xsl:param[@name='number-section9'] " 
        priority = "3"/>

    <xsl:template match="xsl:param[@name='inherit-section-num']" priority = "3">
        <xsl:call-template name="before_p_text">
            <xsl:with-param name="possible-values">
                <xsl:text>True, False</xsl:text>
            </xsl:with-param>
        </xsl:call-template>
        <block>
            If set to 'True', each section inherits the section numbering from the sections
            above it. For example, section '1.1.2' will appear as '1.1.2'. If set to 'False', 
            the section number will appear as '2'.
        </block>
    </xsl:template>

    <xsl:template match="xsl:param" priority="2">
        <xsl:message>
            <xsl:text>no match for "</xsl:text>
            <xsl:value-of select="@name"/>
            <xsl:text>"</xsl:text>
        </xsl:message>
    </xsl:template>


    <xsl:template match="@*|node()" />

    
</xsl:stylesheet>
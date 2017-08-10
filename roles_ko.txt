=========================================
 reStructuredText 해석 텍스트 기능
=========================================

:저자: 데이비드 구저
:연락처: docutils-develop@lists.sourceforge.net
:리비전: $리비전$
:작성일: $작성일$
:저작권: 이 문서는 퍼블릭 도메인에 속한다.

이 문서는 레퍼런스 reStructuredText 파서에 구현된 해석 텍스트 기능을 기술한다.

해석 텍스트는 텍스트 양쪽에 역따옴표(`)를 사용한다.
명시 기능 지정 마커는 선택적으로 텍스트 전이나 후에 나타나고 콜론으로 구분된다. 예시 ::

    디폴트 기능을 사용한 `interpreted text` .

    명시 기능을 사용한 :title:`interpreted text`.

디폴트 기능은 reStructuredText 의 어플리케이션에 의해 정의되며
명시 ``:role:`` 접두어 혹은 접미어가 없을 때 사용된다.
"디폴트 디폴트 기능"은 `:title-reference:`_ 이다.
default-role_ 명령어로 변경될 수 있다.

`reStructuredText 마크업 설명서`_ 의 `해석 텍스트`_ 섹션을 보면 문법적인 세부사항을 알 수 있다.
요소 계층에 대한 세부사항은 `Docutils 문서 계층`_ 과 `Docutils 포괄 DTD`_ XML 문서 타입 정의를 보자.
해석 텍스트 기능 구현에 대한 세부사항은 `reStructuredText 해석 텍스트 기능 생성`_ 을 참고하자.
See the `Interpreted Text`_ section in the `reStructuredText Markup
Specification`_ for syntax details.  For details on the hierarchy of
elements, please see `The Docutils Document Tree`_ and the `Docutils
Generic DTD`_ XML document type definition.  For interpreted text role
implementation details, see `Creating reStructuredText Interpreted
Text Roles`_.

.. _"role" directive: directives.html#role
.. _default-role: directives.html#default-role
.. _해석 텍스트: restructuredtext_ko.html#interpreted-text
.. _reStructuredText 마크업 설명서: restructuredtext_ko.html
.. _The Docutils Document Tree: ../doctree.html
.. _Docutils Generic DTD: ../docutils.dtd
.. _reStructuredText 해석 텍스트 기능 생성:
   ../../howto/rst-roles.html


.. contents::


---------------
 사용자 정의
---------------

사용자 지정 해석 텍스트 기능은 문서 내에서 `"role" 명령어`_ 로 정의된다.
사용자 정의 세부 사항은 각각의 기능에 맞춰 목록화 되어 있다.

.. _class:

``class`` 옵션은 대부분의 해석 텍스트 기능에서 "role" 명령어에 의해 인식된다.
이에 대한 `기술`__ 은 `"role" 명령어`_ 문서에서 제공된다.

__ directives_ko.html#role-class


----------------
 표준 기능
----------------

``:emphasis:``
==============

:별칭: None
:DTD 요소: emphasis
:사용자 정의:
    :Options: class_.
    :Content: None.

강조를 구현한다. 아래의 두줄은 동일하게 구현된다. ::

    *text*
    :emphasis:`text`


``:literal:``
==============

:별칭: None
:DTD 요소: literal
:사용자 정의:
    :Options: class_.
    :Content: None.

인라인 리터럴 텍스트를 구현한다. 아래의 두줄은 동일하게 구현된다. ::

    ``text``
    :literal:`text`

백슬래시 이스케이프는 주의하여 사용해야 한다. 아래 두줄은 동일하게 구현되지 않는다. ::

    ``text \ and \ backslashes``
    :literal:`text \ and \ backslashes`

첫줄의 백슬래시는 보존되고 아무 작용도 하지 않는다.
반면에 아래줄의 백슬래시는 이어서 오는 간격을 취소한다.

``:code:``
==========

:별칭: None
:DTD 요소: literal
:사용자 정의:
    :Options: class_, language
    :Content: None.

(Docutils 0.9.에서 신규 등)

``code`` 기능은 그 내용을 형식 언어 내부의 코드로 표시한다.

`"role" 명령어`_ 를 사용해 "language" 옵션에 명시된 언어로 사용자 지정 기능을 만들면 인라인 코드의 문법 강조를 할 수 있다..

예를 들어, 아래 코드는 LaTeX-특성 "latex" 기능을 구현한다.::

  .. role:: latex(code)
     :language: latex

새로운 기능의 내용은 파싱되고 Pygments_ 문법 하이라이터로 태그된다.
`코드 명령어`_ 에서 파싱과 reStructuredText 에서의 코드 표시에 대한 더 많은 정보를 얻을 수 있다.

"class_" 와 함께 아래 옵션들이 인식된다.:

``language`` : 텍스트
    프로그래밍 언어명.
    `지원 언어와 마크업 포맷`_ 에서 인식되는 값들을 확인하라.

.. _코드 명령어: directives_ko.html#code
.. _Pygments: http://pygments.org/
.. _지원 언어와 마크업 포맷: http://pygments.org/languages/


``:math:``
==========

:별칭: None
:DTD 요소: math
:사용자 정의:
    :Options: class_
    :Content: None.

(Docutils 0.8.에서 신규 등록)

``math`` 기능은 수학적 표기법(인라인 수식)으로 그 내용을 표시한다.

입력 형식은 “math delimiters“ (``$ $``) 를 제외한 LaTeX 수학 문법이다.
예시 ::

  원의 면적은 :math:`A_\text{c} = (\pi/4) d^2`.

`수학 명령어`_ (수식 표시)에서 reStructuredText의 수학적 표기법에 대한 더 많은 정보를 얻을 수 있다.

.. _수학 명령어: directives_ko.html#math


``:pep-reference:``
===================

:별칭: ``:PEP:``
:DTD 요소: reference
:사용자 정의:
    :Options: class_.
    :Content: None.

``:pep-reference:`` 기능은 PEP (Python Enhancement Proposal)로 가는 HTTP 레퍼런스를 생성하는데 사용된다.
``:PEP:`` 별칭이 일반적으로 쓰인다. 예시 ::

    reStructuredText에 대한 추가 정보는 :PEP:`287` 를 보라.

위 예시는 아래와 동치이다. ::

    reStructuredText에 대한 추가 정보는 `PEP 287`__ 를 보라

    __ http://www.python.org/peps/pep-0287.html


``:rfc-reference:``
===================

:별칭: ``:RFC:``
:DTD 요소: reference
:사용자 정의:
    :Options: class_.
    :Content: None.

``:rfc-reference:`` 기능은 RFC (Internet Request for Comments) 로 가는 HTTP 레퍼런스를 생성하는데 사용된다.
``:RFC:`` 별칭이 일반적으로 쓰인다. 예시 ::

    이메일 헤더에 대한 정보는 :RFC:`2822` 를 보라.

위 예시는 아래와 동치이다. ::

    이메일 헤더에 대한 정보는 `RFC 2822`__ 를 보라.

    __ http://www.faqs.org/rfcs/rfc2822.html


``:strong:``
============

:별칭: None
:DTD 요소: strong
:사용자 정의:
    :Options: class_.
    :Content: None.

강한 강조를 구현한다.  아래의 두줄은 동일하게 구현된다. ::

    **text**
    :strong:`text`


``:subscript:``
===============

:별칭: ``:sub:``
:DTD 요소: subscript
:사용자 정의:
    :Options: class_.
    :Content: None.

아래첨자를 구현한다.

.. Tip::

   공백과 구두점은 해석 텍스트 주변에 요구되지만 대체로 아래첨자와 위첨자를 쓰는 것은 권장되지 않는다
   백슬래시 이스케이프도 사용될 수 있고 공백은 처리된 문서에서는 제거된다. ::

       H\ :sub:`2`\ O
       E = mc\ :sup:`2`

   위 예시에서 평문의 가독성은 아래와 같이 대체하면 크게 개선된다. ::

       물 분자의 화학식 |H2O|.

       .. |H2O| replace:: H\ :sub:`2`\ O

   `대체 메카니즘`__ 과 `문자 계층 마크업`__ 에 대한 추가 정보는 `reStructuredText 사양`__ 에서 볼 수 있다.

   __ restructuredtext_ko.html
   __ restructuredtext_ko.html#character-level-inline-markup
   __ restructuredtext_ko.html#substitution-references


``:superscript:``
=================

:별칭: ``:sup:``
:DTD 요소: superscript
:사용자 정의:
    :Options: class_.
    :Content: None.

위첨자를 구현한다. `:subscript:`_ 의 tip 을 참고하라.


``:title-reference:``
=====================

:별칭: ``:title:``, ``:t:``.
:DTD 요소: title_reference
:사용자 정의:
    :Options: class_.
    :Content: None.

``:title-reference:`` 기능은 책, 정기 간행물 등의 표제를 기술할 때 사용한다.
HTML "cite" 요소와 동일하고 보통 HTML 작성기가 "cite"를 사용한 "title_reference" 요소를 구현할 것으로 기대한다.

표제 레퍼런스는 보통 이탤릭체로 구현되므로 주로 ``*강조*`` 를 사용해 마크업 되고 모호해진다.
"title_reference" 요소는 정확하며 모호하지 않은 기술 마크업을 제공한다.

``:title-reference:`` 를 아래 예시의 디폴트 해석 기능으로 가정하자. ::

    `Design Patterns` [GoF95]_ 는 훌륭한 읽을거리이다.

처리를 거치면 아래 (pseudo-XML_) 와 같은 결과가 된다. ::

    <paragraph>
        <title_reference>
            Design Patterns

        <citation_reference refname="gof95">
            GoF95
         는 훌륭한 읽을거리이다.

``:title-reference:`` 표준 reStructuredText 파서의 디폴트 해석 텍스트이다.
reStructuredText의 어플리케이션들은 다른 디폴트 기능을 지정할 수 있으며
``:title-reference:`` 기능은 반드시 ``title_reference`` 요소를 받는데 사용되어야 한다.


.. _pseudo-XML: ../doctree.html#pseudo-xml


-------------------
 특정 기능
-------------------

``raw``
=======

:별칭: None
:DTD 요소: raw
:사용자 정의:
    :Options: class_, format
    :Content: None

.. WARNING::

   "raw" 명령어는 저자가 reStructuredText의 마크업으로 우회할 수 있게 하는 임시 방편으로
   오남용 되어선 안되며 파워 유저를 위한 기능이다.
   "raw" 명령어의 사용은 문서를 특정 출력 포맷으로 묶어 휴대성이 떨어지게 한다.

   "raw" 명령어나 이로부터 파생된 해석 텍스트 기능을 자주 사용해야 한다면
   오남용의 신호이거나 reStructuredText 의 사용 목적에서 벗어난 것일 수 있다.
   그럴 경우 당신의 상황을 Docutils-users_ 메일 리스트로 보내길 바란다.

   .. _Docutils-users: ../../user/mailing-lists.html#docutils-user

"raw" 명령어는 작성기를 건드려지지 않고 통과할 non-reStructuredText 데이터를 지정한다.
``raw`` 와 동등한 인라인 명령어는 `"raw" 명령어`_ 다. ;
"raw" 명령어 문서에서 의미적인 세부사항을 볼 수 있다.

.. _"raw" 명령어: directives.html#raw-directive

"raw" 기능을 곧바로 사용해선 안된다.
`"role" 명령어`_ 는 먼저 "raw" 기능에 기반한 사용자 지정 기능을 생성하는데 사용되어야 한다.
하나 이상의 포맷(작성기명)이 "format" 옵션에 규정되어 있어야 한다.

예를 들어 아래 내용은 HTML-specific "raw-html" 기능을 생성한다. ::

    .. role:: raw-html(raw)
       :format: html

이 기능은 데이터를 처리되지 않은 채로 HTML 작성기로 보내는데 사용된다. 예시 ::

    If there just *has* to be a line break here,
    :raw-html:`<br />`
    it can be accomplished with a "raw"-derived role.
    But the line block syntax should be considered first.

.. Tip:: Roles based on "raw" should clearly indicate their origin, so
   they are not mistaken for reStructuredText markup.  Using a "raw-"
   prefix for role names is recommended.

"class_" 와 함께 아래 옵션이 인식된다.:

``format`` : 텍스트
    간격으로 구분 되는 1개 이상의 출력 포맷명 (작성기명)

==================================
 reStructuredText 표준 정의 파일
==================================
:저자: 데이비드 구저
:연락처: docutils-develop@lists.sourceforge.net
:리비전: $리비전$
:날짜: $날짜$
:저작권: 이 문서는 퍼블릭 도메인에 속한다.

.. contents::


이 문서는 대체 정의, 번역 텍스트 기능과 같이 reStructuredText 문서에 포함될 수 있는 정의 파일들을 기술한다.
`"include" 명령어`__ 는 표준 정의 파일을 위한 특별한 문법을 갖는다. 이를 위 꺽쇠괄호를 사용한다.::

    .. include:: <파일명.txt>

__ directives_ko.html#include

각각의 데이터 파일들은 "docutils" 패키지 내부에 Docutils 소스코드와 함께 저장된다.
이 파일들의 경로는 ``docutils/parsers/rst/include`` 이다.


대체 정의
============

다수의 표준 정의 파일들은 문서 내부의 `대체 레퍼런스`__ 를 통해 사용할 수 있는 `대체 정의`__ 의 묶음을 포함한다.
예를 들어 저작권 기호는 "사본"으로 ``isonum_ko.txt`` 에 저장되어 있다.::

    .. include:: <isonum.txt>

    저작권 |사본| 2003 by John Q. Public, 판권소유.

__ restructuredtext_ko.html#substitution-definitions
__ restructuredtext_ko.html#substitution-references

각각의 대체 정의들은 정의 파일로부터 복사되거나 문서로 붙여넣기 할 수 있다.
이 기능은 두가지 장점을 갖는다. 이로 인해 의존성이 제거되고 사용되지 않은 정의들의 처리를 저장한다.
그러나 다수의 대체 정의는 문서를 복잡하게 만든다.

대체 레퍼런스는 공백이나 구두점을 사용해 인접한 텍스트와 구별해 주어야 한다.
공백을 사용하지 않는다면 백슬래시 이스케이프 시퀀스를 사용하면 된다.::

    .. include:: isonum.txt

    저작권 |사본| 2003, BogusMegaCorp\ |trade|.

커스텀 대체 정의는 `"unicode" 명령어`__ 를 사용할 수 있다.
공백은 무시되거나 삭제되어 실제로는 텍스트에 녹아든다.::

    .. |사본|   unicode:: U+000A9 .. COPYRIGHT SIGN
    .. |BogusMegaCorp (TM)| unicode:: BogusMegaCorp U+2122
       .. with trademark sign

    저작권 |사| 2003, |BogusMegaCorp (TM)|.

__ directives_ko.html#unicode

추가로 대체 레퍼런스에서 "unicode" 명령어와 함께 "ltrim", "rtrim" "trim" 을 사용하면 자동으로 공백을 제거해 준다.
"ltrim"은 왼쪽, "rtrim"은 오른쪽, "trim"은 양쪽으로부터 공백을 제거한다.::

    .. |---| unicode:: U+02014 .. em dash
       :trim:


문자 객체 집합
---------------------

아래의 파일들은 XML 문자 객체 집합에 대응되는 대체 정의들로 다음의 표준을 따른다. :
ISO 8879 & ISO 9573-13 (combined), MathML, and XHTML1.
이 파일들은 ``tools/dev/unicode2rstsubs.py`` 프로그램에 unicode.xml__ 을 입력으로 받아 생성되었다.
입력이 되는 unicode.xml__ 은 MathML 2 Recommentation XML source 의 일부로서 지원 받고 있다.

__ http://www.w3.org/2003/entities/xml/

===================  =================================================
Entity Set File      Description
===================  =================================================
isoamsa.txt_         Added Mathematical Symbols: Arrows
isoamsb.txt_         Added Mathematical Symbols: Binary Operators
isoamsc.txt_         Added Mathematical Symbols: Delimiters
isoamsn.txt_         Added Mathematical Symbols: Negated Relations
isoamso.txt_         Added Mathematical Symbols: Ordinary
isoamsr.txt_         Added Mathematical Symbols: Relations
isobox.txt_          Box and Line Drawing
isocyr1.txt_         Russian Cyrillic
isocyr2.txt_         Non-Russian Cyrillic
isodia.txt_          Diacritical Marks
isogrk1.txt_         Greek Letters
isogrk2.txt_         Monotoniko Greek
isogrk3.txt_         Greek Symbols
isogrk4.txt_  [1]_   Alternative Greek Symbols
isolat1.txt_         Added Latin 1
isolat2.txt_         Added Latin 2
isomfrk.txt_  [1]_   Mathematical Fraktur
isomopf.txt_  [1]_   Mathematical Openface (Double-struck)
isomscr.txt_  [1]_   Mathematical Script
isonum.txt_          Numeric and Special Graphic
isopub.txt_          Publishing
isotech.txt_         General Technical
mmlalias.txt_        MathML aliases for entities from other sets
mmlextra.txt_ [1]_   Extra names added by MathML
xhtml1-lat1.txt_     XHTML Latin 1
xhtml1-special.txt_  XHTML Special Characters
xhtml1-symbol.txt_   XHTML Mathematical, Greek and Symbolic Characters
===================  =================================================

.. [1] ``*-wide.txt`` 와 같은 형태의 파일들이 있다. 이러한 형태의 파일들은
       유니코드 다국어 평면이나 BMP 바깥의 문자들을 포함한다.
       (wide-Unicode; U+FFFF 보다 큰 코드 포인트)
       이미 구현되어 있는 대부분의 파이썬 배포들은 "한정"되어 있고 wide-Unicode 문자를 지원하지 않는다.
       파이썬을 wide-Unicode로 구현할 수 있지만 세부사항은 파이썬 개발 지침서를 참고하라.

예를 들어 저작권 기호는 XML 문자 객체 ``&copy:`` 로 정의되어 있다.
이에 대응하는 reStructuredText 대체 레퍼런스(``isonum.txt`` 와 ``xhtml_lat1.txt`` 로 정의됨)는 ``|copy|`` 이다.

.. _isoamsa.txt:        ../../../docutils/parsers/rst/include/isoamsa.txt
.. _isoamsb.txt:        ../../../docutils/parsers/rst/include/isoamsb.txt
.. _isoamsc.txt:        ../../../docutils/parsers/rst/include/isoamsc.txt
.. _isoamsn.txt:        ../../../docutils/parsers/rst/include/isoamsn.txt
.. _isoamso.txt:        ../../../docutils/parsers/rst/include/isoamso.txt
.. _isoamsr.txt:        ../../../docutils/parsers/rst/include/isoamsr.txt
.. _isobox.txt:         ../../../docutils/parsers/rst/include/isobox.txt
.. _isocyr1.txt:        ../../../docutils/parsers/rst/include/isocyr1.txt
.. _isocyr2.txt:        ../../../docutils/parsers/rst/include/isocyr2.txt
.. _isodia.txt:         ../../../docutils/parsers/rst/include/isodia.txt
.. _isogrk1.txt:        ../../../docutils/parsers/rst/include/isogrk1.txt
.. _isogrk2.txt:        ../../../docutils/parsers/rst/include/isogrk2.txt
.. _isogrk3.txt:        ../../../docutils/parsers/rst/include/isogrk3.txt
.. _isogrk4.txt:        ../../../docutils/parsers/rst/include/isogrk4.txt
.. _isolat1.txt:        ../../../docutils/parsers/rst/include/isolat1.txt
.. _isolat2.txt:        ../../../docutils/parsers/rst/include/isolat2.txt
.. _isomfrk.txt:        ../../../docutils/parsers/rst/include/isomfrk.txt
.. _isomopf.txt:        ../../../docutils/parsers/rst/include/isomopf.txt
.. _isomscr.txt:        ../../../docutils/parsers/rst/include/isomscr.txt
.. _isonum.txt:         ../../../docutils/parsers/rst/include/isonum.txt
.. _isopub.txt:         ../../../docutils/parsers/rst/include/isopub.txt
.. _isotech.txt:        ../../../docutils/parsers/rst/include/isotech.txt
.. _mmlalias.txt:       ../../../docutils/parsers/rst/include/mmlalias.txt
.. _mmlextra.txt:       ../../../docutils/parsers/rst/include/mmlextra.txt
.. _xhtml1-lat1.txt:    ../../../docutils/parsers/rst/include/xhtml1-lat1.txt
.. _xhtml1-special.txt: ../../../docutils/parsers/rst/include/xhtml1-special.txt
.. _xhtml1-symbol.txt:  ../../../docutils/parsers/rst/include/xhtml1-symbol.txt


S5/HTML 정의
===================

"s5defs.txt_" 표준 정의 파일은 번역 텍스트 기능(클래스)와 문서들을 위한 다른 정의들을 포함한다.
이 정의 파일은 `S5/HTML slide shows`_ 가 된다.

.. _s5defs.txt: ../../../docutils/parsers/rst/include/s5defs.txt
.. _S5/HTML slide shows: ../../user/slide-shows.html


..
   Local Variables:
   mode: indented-text
   indent-tabs-mode: nil
   sentence-end-double-space: t
   fill-column: 70
   End:

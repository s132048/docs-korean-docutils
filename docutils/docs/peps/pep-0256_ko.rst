===================================================
PEP 256 -- Docstring Processing System Framework
===================================================
:PEP: 256
:버전: $Revision$
:수정날짜: $Date$
:저자: David Goodger <goodger@python.org>
:토론-연락: <doc-sig@python.org>
:상태: Draft
:유형: Standards Track
:내용-유형: text/x-rst
:생성날짜: 01-Jun-2001
:포스팅-날짜: 13-Jun-2001

.. contents::

개요
========

Python은 inline documentation이 가능하다. Python에서는 내재된 docstring syntax를 이용하여 제한된 형태의 `Literate Programming`_ (쉽게 읽히는 프로그래밍)이 쉽게 구현 가능하다. 그러나 Python의 docstring을 추출하고 처리하기 위한 만족스러운 standard tool은 아직 없으며, 이 PEP는 이러한 표준의 부재로 인한 문제점을 해결하기 위한 것이다.

Docstring의 처리와 관련된 문제는 쟁점이 되어왔으며 해결하기 또한 어렵다. 이 PEP에서는 일반적인 Docstring Processing System (DPS) framework를 제안한다. 이는 구성 요소(프로그램과 개념)를 분리함으로써, 합의(단일 해결책) 또는 분기(여러 해결책)를 통하여 각 문제를 해결할 수 있고 다양한 plugin (input context reader, markup parser, output format writer)을 사용할 수 있는 standard interface를 장려한다.

DPS framework의 개념은 구현 방법과는 독립적으로 제공된다.


Docstring PEP에 대한 로드맵
==============================

Docstring 처리에는 여러가지 측면이 있다. "Docstring PEP"는 각 이슈들을 독립적으로 해결하기 위해 이슈들을 나누었다. 관련된 PEP들은 다음과 같다.

* Docstring syntax. PEP 287, "reStructuredText Docstring Format"
  [#PEP-287]_ 은 Python docstring, PEP 등을 위한 syntax를 제시한다.
  

* Docstring semantics는 다음과 같은 두가지 측면이 있다:

  - 규약: Docstring의 high-level 구조. PEP 257, "Docstring Conventions" [#PEP-257]_ 에서 다루어진다.

  - 방법론: Docstring의 내용에 대한 규칙들. 아직 거론되지 않는다.

* 처리 메커니즘. 이 PEP (PEP 256)에서는 DPS의 specification과 high-level에서의 문제들이 요약되어 있다. PEP 258, "Docutils Design Specification" [#PEP-258]_, 은 현재 개발중인 DPS의 설계 및 구현에 대한 개요이다.

* 출력 스타일: 개발자는 소스 코드에서 생성 된 documentation을 보기 좋게 만들기를 원하며, 그게 무엇을 의미하는지는 여러 가지 의견이 있다. PEP 258은 "Stylist Transforms"를 다루고 있다. Docstring 처리의 이러한 측면은 아직 추가적인 분석이 필요하다.




근거
===========

다른 언어에는 이미 표준 inline documentation 시스템이 있다. 예를 들어, Perl은 POD_ ( "Plain Old Documentation")를 가지고 있고 Java는 Javadoc_ 을 가지고 있지만 이 두가지 방식은 Pythonic하지 않기에 Python에서 사용하기에는 적합하지 않다. POD syntax는 매우 명확하지만 가독성이 떨어지며, Javadoc은 "``@ field``"태그를 제외하고는 HTML이 마크업에 사용되어 매우 HTML스럽다. 또한 Autoduck_ 및 Web_ (Tangle & Weave)과 같은 여러 언어에 쓰이는 일반적인 도구가 있기도 하다.

Python에 대한 자동 documentation 시스템을 만들려는 다음과 같은 많은 시도가 있었다:

- Marc-Andre Lemburg의 doc.py_

- Daniel Larsson의 pythondoc_ & gendoc_

- Doug Hellmann의 HappyDoc_

- Laurence Tratt의 Crystal (더 이상 웹에서 볼 수 없음)

- Ka-Ping Yee의 pydoc_ (pydoc.py는 이제 Python 의 standard library의 일부. 아래 참조)

- Tony Ibbs의 docutils_ (Tony는 이 이름을 `Docutils project`_ 에 기부)

- Edward Loper의 STminus_ 공식화 및 관련 노력들

각기 다른 목표를 가진 위의 여러 시스템은 다양한 수준의 성공을 거두었지만, 대부분의 시스템은 너무 큰 목표와 부족한 유연성으로 인해 여러 문제점을 가지고 있다. 그들은 독립된 세트로 docstring 추출 시스템, markup parser, 내부 처리 시스템, 고정 된 스타일을 가진 output format writer를 모두 포함하여 제공했다. 필연적으로 각 시스템에서는 하나 이상의 심각한 단점이 있으며, 쉽게 확장하거나 수정하지 못하여 표준 도구로 채택되는데 방해가 되었다.

그 어떠한 단일 시스템도 모든 이해 당사자들의 지지를 얻기 힘들기 때문에 "모 아니면 도"식으로 접근하는 방식은 옳지 못하다. 따라서 확장을 염두에 둔 modular한 방식이 유일한 해결책이라고 볼 수 있다. 구성요소 간의 standard API는 DPS 전체에 대한 상세한 지식 없이도 개별 구성요소의 이해를 가능하게 하며, 기여에 대한 장벽을 낮추고, 궁극적으로 풍부한 시스템을 만들 수 있게 해준다.

따라서 DPS의 각 구성 요소는 독립적으로 개발되어야 하며, 최상의 시스템은 "선택"을 통해 만들어져야 한다. 이는 기존 시스템과 통합되거나 새롭게 개발되어야한다. 이 시스템은 Python의 standard library에 포함되어야 한다.


PyDoc 및 기타 기존 시스템
------------------------------

PyDoc은 2.1 버전부터 Python standard library의 일부가 되었다. PyDoc은 Python interactive interpreter, shell command line, GUI 창에서 웹 브라우저(HTML)로 docstring을 추출하여 표시한다. 매우 유용한 도구이지만 PyDoc에는 다음과 같은 몇 가지 결함이 있다.

- 식별자 이름에 heuristic하게 hyperlink를 사용하는 것을 제외하고는 GUI / HTML의 경우 docstring 형식을 변형하지 않는다. 단지 ``<p><small><tt>`` 태그를 사용하여 원하지 않는 줄바꿈을 피할 뿐이다. 불행히도 그 결과는 그다지 매력적이지 않다.

- PyDoc은 가져온 module 객체에서 docstring과 구조 정보(class 식별자, method 서명 등)를 추출한다. 여기에는 신뢰할 수 없는 코드를 가져 오기는 것에 대한 보안 문제가 있다. 또한 "추가 docstring"(docstring 문맥 외에 쓰인 string literal. PEP 258 [#PEP-258]_ 참조) 및 정의 순서와 같은 정보들이 import 과정에서 손실된다.

이 PEP에서 제안 된 기능은 HTML 페이지를 제공 할 때 PyDoc에 추가되거나 PyDoc에 의해 사용 될 수 있다. 제안 된 DPS의 기능은 현재의 PyDoc이 필요로 하는 것 이상을 제시한다. 새로운 도구가 개발되거나, PyDoc이 확장되어 표준 DPS(또는 그러한 시스템 중 하나)가 될 수도 있다. 하지만 이에 대한 내용은 이 PEP의 범위를 벗어난다.

다른 기존 DPS들도 마찬가지로, 작성자들은 이 framework와의 호환성을 선택할 수도 있고 선택하지 않을 수도 있다. 그러나 이 framework가 Python 표준으로 채택된다면 호환성은 DPS들에 있어 미래에 중요한 고려 사항이 될 것이다.


상세
=============

DPS framework는 다음과 같이 나뉘어져 있다:

1. Docstring 규약. 다음과 같은 문제들을 다룬다:

   - 어디에 무엇이 documentation 되어야 하는가.

   - 첫번째 줄은 한줄 요약이다.

   PEP 257 [#PEP-257]_ 가 이 문제들 중 일부를 다룬다.

2. DPS 설계 specification. 다음과 같은 문제들을 다룬다:

   - High-level spec: DPS가 무엇을 수행하는지에 대해서.

   - 실행 가능한 스크립트용 command-line interface.

   - 시스템 Python API.

   - Docstring 추출 규칙.

   - Input context를 encapsulate하는 Reader.

   - Parser.

   - 문서 트리: 중간 단계의 내부적 data structure. Parser와 Reader의 output과 Writer에 대한 input은 모두 같은 data structure를 가진다.

   - 문서 트리를 변환하는 Transform.

   - Output format을 위한 Writer.

   - Output 관리(파일 하나, 여러 파일, 또는 메모리 내의 객체)를 다루는 Distributor.

   위 문제들은 모든 DPS의 구현과 관련이 있다. PEP 258 [#PEP-258]_ 는 이러한 문제들을 다룬다.

3. DPS 구현.

4. Input markup specification: docstring syntax. PEP 287 [#PEP-287]_
   은 standard syntax를 제안한다.

5. Input parser 구현.

6. Input context reader("모드"들: Python 소스 코드, PEP, 단독
   텍스트 파일, 이메일 등)와 그의 구현.

7. Stylist: 특정한 input context reader는 연계되는 stylist들이 있을 수 있어 다양한 output 문서 형식을 허용할 수 있다.

8. Output 형식(HTML, XML, TeX, DocBook, info 등)과 writer 구현.

구성 요소 1, 2/3/5, 그리고 4는 개별 PEP의 대상이다. 이 framework 또는 syntax/parser의 다른 구현방식이 생긴다면, 추가적인 PEP가 필요할 수 있다. 구성 요소 6과 7은 여러 구현이 필요할 것이다. 하지만 PEP 메커니즘은 이러한 구성 요소에 대해 과도한 작업일 수 있다.


프로젝트 웹사이트
=====================

이 작업을 위한 SourceForge 프로젝트:
http://docutils.sourceforge.net/.


참고 문헌 및 각주
======================

.. [#PEP-287] PEP 287, reStructuredText Docstring Format, Goodger
   (http://www.python.org/peps/pep-0287.html)

.. [#PEP-257] PEP 257, Docstring Conventions, Goodger, Van Rossum
   (http://www.python.org/peps/pep-0257.html)

.. [#PEP-258] PEP 258, Docutils Design Specification, Goodger
   (http://www.python.org/peps/pep-0258.html)

.. _Literate Programming: http://www.literateprogramming.com/

.. _POD: http://perldoc.perl.org/perlpod.html

.. _Javadoc: http://java.sun.com/j2se/javadoc/

.. _Autoduck:
   http://www.helpmaster.com/hlp-developmentaids-autoduck.htm

.. _Web: http://www-cs-faculty.stanford.edu/~knuth/cweb.html

.. _doc.py:
   http://www.egenix.com/files/python/SoftwareDescriptions.html#doc.py

.. _pythondoc:
.. _gendoc: http://starship.python.net/crew/danilo/pythondoc/

.. _HappyDoc: http://happydoc.sourceforge.net/

.. _pydoc: http://www.python.org/doc/current/lib/module-pydoc.html

.. _docutils: http://www.tibsnjoan.co.uk/docutils.html

.. _Docutils project: http://docutils.sourceforge.net/

.. _STMinus: http://www.cis.upenn.edu/~edloper/pydoc/

.. _Python Doc-SIG: http://www.python.org/sigs/doc-sig/


저작권
=========

이 문서는 공개 도메인에 속한다.


감사 인사
================

이 문서는 `Python Doc-SIG`_ 의 아카이브에서 아이디어를 차용하였습니다. 과거와 현재의 회원 모두에게 감사의 메세지를 보냅니다.



..
   Local Variables:
   mode: indented-text
   indent-tabs-mode: nil
   sentence-end-double-space: t
   fill-column: 70
   End:

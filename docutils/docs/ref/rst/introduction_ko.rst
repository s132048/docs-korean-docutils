=====================================
 reStructuredText 소개
=====================================
:저자: 데이비드 구저
:연락처: docutils-develop@lists.sourceforge.net
:리비전: $리비전$
:작성일: $작성일$
:저작권: 이 문서는 퍼블릭 도메인에 속한다.

reStructuredText_ 는 평문 마크업 문법과 파싱 시스템으로 가독성이 좋고 보이는 것 그대로 결과가 된다는 장점이 있다.
단일 문서나 인라인 프로그램 문서 (파이썬 docstring) 작업 또는 빠르게 간단한 웹페이지를 만들어야 할 때 유용하다.
StructuredText_ 와 Setext_ 간편 마크업 시스템의 재해석과 개정이 reStructuredText_ 이다.

reStructuredText 는 특정 어플리케이션들의 도메인의 확장성을 위해 고안되었다.
reStructuredText 파서는 Docutils 의 구성요소이다.

이 문서는 reStructuredText의 `목표`_ 를 분명히 하고 이 프로젝트의 `이력`_ 을 제공한다.
reStructuredText 의 마크업으로 작성되었으므로 reStructuredText의 사용 예시가 된다.
reStructuredText 사용에 대한 친절한 설명은 `ReStructuredText 입문`_ 을 참고하라.
`Quick reStructuredText`_ 사용자 레퍼런스도 유용할 것이다.
`reStructuredText 마크업 설명서`_ 가 가장 정확한 레퍼런스이다.
`StructuredText 문제점`_ 에 대한 분석도 있다.

ReStructuredText 의 웹페이지 http://docutils.sourceforge.net/rst.html.

.. _reStructuredText: http://docutils.sourceforge.net/rst.html
.. _StructuredText:
    http://www.zope.org/DevHome/Members/jim/StructuredTextWiki/FrontPage
.. _Setext: http://docutils.sourceforge.net/mirror/setext.html
.. _Docutils: http://docutils.sourceforge.net/
.. _ReStructuredText 입문: ../../user/rst/quickstart.html
.. _Quick reStructuredText: ../../user/rst/quickref.html
.. _reStructuredText 마크업 설명서: restructuredtext_ko.html
.. _StructuredText 문제점: ../../dev/rst/problems.html


목표
=======

reStructuredText_ 의 주된 목표는 파이썬 docstring 과 다른 문서 도메인에서 사용할 마크업 문법의 정의이다.
마크업 문법은 가독성이 좋고 간편해야 하며 중요한 용도에 쓰일 만큼 강력해야 한다.
reStructuredText 마크업이 목표로 하는 것 두가지이다. :

- 표준 규칙 세트를 확립하여 평문 내부 구조의 표현을 가능하게 한다.

- 문서들을 유용한 데이터 포맷들로 변환한다.

reStructuredText 의 이차 목표는 파이썬 인라인 문서화의 표준으로서 파이썬 커뮤니티에 인정받는 것이다.
(PythonLabs 과 BDFL [#]_ 덕에) 여러 표준 중 하나로 취향에 의존한다.

.. [#] 파이썬 창시자와 "Benevolent Dictator For Life",
   Guido van Rossum.

주 목표를 분명히 하기 위해 구체적인 디자인 목표들이 중요한 순서대 나열되어 있다. :

1. Readable. 마크업된 텍스트는 마크업 언어에 대한 선행지식 없이도 쉽게 읽을 수 있어야 한다.
   미처리 형식에서도 처리된 형식 만큼 읽기 쉬어야 한다.

2. Unobtrusive.  사용될 마크업은 가능한 한 간편하고 단순해야 한다.
   자주 사용되는 마크업일수록 단순해야 한다.
   가장 보편적인 구조들은 자연스럽고 분명한 마크업으로 가장 간단해야 한다.
   자연스럽고 분명한 마크업이 없는 덜 보편적인 구조들도 구분 가능해야 한다.

3. Unambiguous. 마크업 규칙들은 해석에 대해 열려 있어선 안된다.
   어떤 입력에 대해서도 입력당 단 하나의 출력만 있어야 한다. (오류 출력 포함)

4. Unsurprising. 마크업 구조는 프로세싱에서 예상치 못한 출력을 야기해선 안된다.
   이에 대한 대비책으로 마크업 하지 않을 문맥에 마크업 구조가 사용됐을 때
   원치 않는 마크업 구현을 막을 방법이 있어야 한다.
   (예를 들어 마크업 문법 그 자체를 문서화 하고자 할 때)

5. Intuitive.  마크업은 작성자와 독자 모두에게 가능한 한 분명하고 기억하기 쉬워야 한다.
   구조는 possible, for the author as well as for the reader.  Constructs
   should take their cues from such naturally occurring sources as
   plaintext email messages, newsgroup postings, and text
   documentation such as README.txt files.

6. Easy.  일반적으로 사용되는 어떤 문서 작성기에서도 텍스트를 손쉽게 마크업할 수 있어야 한다.

7. Scalable.  텍스트의 길이와 상관없이 마크업을 적용할 수 있어야 한다.

8. Powerful.  마크업은 풍부한 구조를 갖는 문서를 작성하기에 부족함 없는 구조를 제공해야 한다.

9. Language-neutral.  마크업은 영어뿐 아니라 다수의 자연어(인공어 포함)에 적용할 수 있어야 한다.

10. Extensible.  마크업은 단순한 문법과 인터페이스를 제공하여
    보다 복잡한 표준 마크업과 커스텀 마크업을 추가할 수 있어야 한다.

11. Output-format-neutral.  마크업은 다수의 출력 포맷을 처리하기에 적절해야 하고
    특정 포맷에 치우쳐선 안된다.

위의 디자인 목표들은 문법을 수용, 기각하거나 대안을 선정할 때 기준이 된다.

분명히 말해서 reStructuredText 의 목표는 doctring 컨텐츠나 길이와 같은 doctring 속성들을 정의하는 것이 아니다.
이러한 쟁점들은 마크업 문법과 별개이며 이 설명서의 범위를 벗어난다.

또한, StructuredText_ 나 Setext_ 와의 호환성을 강화하는 것도 reStructuredText 의 목표가 아니다.
reStructuredText 는 두 포맷의 장점만을 참고한다.

저자 노트:

    우리가 해결하고자 하는 문제(또는 제안된 해결책)의 본질로 인해 위의 목표들은 충돌할 수 밖에 없다.
    파이썬 Doc-SIG_ 메일 리스트와 여러 곳에 다년간 축적된 지식을 참고하여
    일관된 문법 규칙 세트를 제안하고 위 목표들을 달성하기 위해 노력해 왔다.

    사람들이 나의 몇몇 결정들을 반대하는 것은 피할 수 없다.
    마크업을 보다 세세하게 관리하길 원하는 사람도 있고 그 반대를 주장하는 사람도 있다.
    매우 간결 docstring이 선호되기도 하고 완성된 문서가 선호되는 경우도 있다.
    이 설명서는 충분히 간결한 형식 내에서 충분히 풍부한 마크업 구조 세트를 제공하여
    충분히 큰 규모의 합리적인 사용자 집단을 만족시키고자 하는 노력의 일환이다.

    데이비드 구저 (goodger@python.org), 2001-04-20

.. _Doc-SIG: http://www.python.org/sigs/doc-sig/


이력
=======

reStructuredText_ 설명서는 StructuredText_ 와 Setext_ 에 기반한다.
StructuredText 는 `Zope Corporation`_ (이전엔 Digital Creations)의
Jim Fulton 에 의해 개발되고 1996년 처음 배포되었다.
현재는 오픈소스 "Z Object Publishing Environment" (ZOPE_) 의 일부로 배포되고 있다.
Ian Feldman 와 Tony Sanders 의 초창기 Setext_ 설명서는 그 유사성으로 인해
StructuredText 에 영향을 주었고 이러한 접근에 대한 정당성을 주는 최소한의 근거가 된다.

1999년 말, 프로젝트를 진행하던 중 파이썬 모듈을 작성할 방법을 찾다가 StructuredText_ 를 발견했다.
StructuredText 1.1 버전은 Larsson's pythondoc_ 에 속해 있었다.
내 작업을 위한 pythondoc 은 구할 수 없었지만 StructuredText 가 나의 필요에 가장 이상적이라고 생각했다.
필자는 파이썬 Doc-SIG_ (Documentation Special Interest Group) 메일링 리스트에 가입했고
StructuredText "표준"이 갖는 결점에 대한 논의가 진행중이라는 것을 알았다.
이 논의는 1996년 메일링 리스트가 시작된 이래로 진행되어 왔고 그 이전에 시작됐을 수도 있다.

필자의 확장과 Doc-SIG 회원의 제안에 기반해 기존 모듈을 수정하기로 했다.
곧 기존 모듈이 필자가 가진 확장으로 작성되지 않았다는 것을 알았고
이를 "re" 정규 표현 모듈에 이식하는 것을 포함한 전면적인 재작업을 시작하기로 했다.
(이 작업이 reStructuredText 의 작명에 영감을 주었다.)
수정을 끝내고 얼마 지나지 않아 ZOPE 배포의 StructuredText.py 이 1.23 버전까지 포함되었다는걸 알게 되었다.
모듈의 복잡성이 너무 심해져 1.23 버전으로부터 새로운 문법 확장을 이식하는 것은 절망적인 일이 되었다.

2000년에 `Zope Corporation`_ 에서 StructuredTextNG_ ("Next Generation") 의 개발이 시작되었다.
많이 개선되긴 했지만 여전히 기존 StructuredText 이 갖는 많은 문제들을 안고 있었다.

이에 필자는 완전히 새로 작성할 때가 됐다고 결심했고
`reStructuredText SourceForge project`_ (현재는 비활성화) 를 시작했다.
필자의 동기는 아래와 같다. :

- 필자는 작성중인 프로그램의 인라인 문서화를 위한 표준 포맷이 필요했다.
  이 인라인 문서화는 HTMl과 같은 유용한 포맷들로 변환될 수 있어야 한다.
  필자와 같은 필요성을 느낀 사람들이 많다고 생각한다.

- Setext/StructuredText 의 구상을 지지하고 표준의 형식화를 돕고 싶다.
  그러나 현재의 사양와 구현은 개선을 분명히 필요로 하는 결점을 갖고 있다.

- reStructuredText 은 파이썬에 이로운 문서 추출과 처리 시스템을 위한 기반의 일부를 구성할 수 있다.
  하지만 이는 전체가 될 수 없고 일부일 뿐이다.
  reStructuredText 는 마크업 언어 사양과 레퍼런스 파서의 구현이지만 시스템 전부를 구성하려 하진 않는다.
  필자는 과도한 욕심으로 reStructuredText 나 가상의 파이썬 문서 프로세서가 사산되는건 원치 않는다.

- 무엇보다 많은 프로그래머들의 골칫거리인 문서화 업무를 수월하게 하는데 기여하고 싶다.

불행히도 필자는 이 프로젝트에서 이탈했고 관련 업무를 중단하였다.
2000년 11월에 StructuredText 의 문제들과 가능한 해결책들을 열거하기 위한 시간을 냈고
사양의 초안을 냈다. 이 초안은 세 부분에 나뉘어 Doc-SIG 에 개재되었다. :

- `A Plan for Structured Text`__
- `Problems With StructuredText`__
- `reStructuredText: Revised Structured Text Specification`__

__ http://mail.python.org/pipermail/doc-sig/2000-November/001239.html
__ http://mail.python.org/pipermail/doc-sig/2000-November/001240.html
__ http://mail.python.org/pipermail/doc-sig/2000-November/001241.html

2001년 3월 Doc-SIG 에서의 분주한 활동이 필자로 하여금
위 사양의 개정에 박차를 가하게 했고 결과는 독자가 읽고 있는 것과 같다.
reStructuredText 프로젝트를 통해 아무리 잘 고안되었더라도 단일 마크업 체계는 부족하는 것을 알게 되었다.
Doc-SIG에서 끝나지 않는 토론을 달래기 위해 유연한 `Docstring Processing System framework`_ 을 구현할 필요가 있었다.
이 프레임워크는 두개의 중요한 프로젝트가 되었다.;
reStructuredText_ 는 보다 큰 프레임워크의 단일 요소를 위한 선택지 중 하나로 자리 잡았다.

프로젝트 웹사이트와 첫번째 프로젝트의 배포는 2001년 5월에 진행됐다.
이 배포에는서 사양의 두번째 안 [#spec-2]_ 과 PEPs 256, 257, 258 의 초안이 [#peps-1]_
Doc-SIG 에 개재되었다. 이 문서와 프로젝트 구현은 빠른 속도로 진전되었다.
구현 이력에 대한 세부사항은 `project history file`_ 을 참고하라.

2001년 11월에 reStructuredText 파서가 완성을 앞두고 있었다.
파서의 개발은 작은 편의요소의 추가, 문법 개선, 공백 매우기, 버그 수정을 계속하고 있었다.
긴 연휴를 끝내고 2002년 초에 대부분의 개발이 다른 Docutils 요소들 ("Readers", "Writers", "Transforms") 로 이전되었다.
단독 리더(단독 텍스트 파일 문서를 처리)가 2월에 완료되었고 기본 HTML 작성기(CSS-1을 이용한 HTMl 4.01)가 3월초에 완성되었다.

`PEP 287`_, "reStructuredText Standard Docstring Format" 은 reStructuredText 를
파이썬 docstring, PEPs, 이 외 다른 파일들을 위한 표준 포맷으로 공식 제안하기 위해 작성되었다.
2002-04-02 에 comp.lang.python_ 와 Python-dev_ 메일링 리스트에 처음 개재되었다.

reStructuredText__ 의 버전 0.4와  `Docstring Processing System`_ 프로젝트는 2002년 4월에 배포되었다.
이 두 프로젝트는 바로 통합되었고 "Docutils_" 로 개명 되어 0.1 에 배포되었다.

.. __: `reStructuredText SourceForge project`_

.. [#spec-2] The second draft of the spec:

   - `An Introduction to reStructuredText`__
   - `Problems With StructuredText`__
   - `reStructuredText Markup Specification`__
   - `Python Extensions to the reStructuredText Markup
     Specification`__

   __ http://mail.python.org/pipermail/doc-sig/2001-June/001858.html
   __ http://mail.python.org/pipermail/doc-sig/2001-June/001859.html
   __ http://mail.python.org/pipermail/doc-sig/2001-June/001860.html
   __ http://mail.python.org/pipermail/doc-sig/2001-June/001861.html

.. [#peps-1] First drafts of the PEPs:

   - `PEP 256: Docstring Processing System Framework`__
   - `PEP 258: DPS Generic Implementation Details`__
   - `PEP 257: Docstring Conventions`__

   Current working versions of the PEPs can be found in
   http://docutils.sourceforge.net/docs/peps/, and official versions
   can be found in the `master PEP repository`_.

   __ http://mail.python.org/pipermail/doc-sig/2001-June/001855.html
   __ http://mail.python.org/pipermail/doc-sig/2001-June/001856.html
   __ http://mail.python.org/pipermail/doc-sig/2001-June/001857.html


.. _Zope Corporation: http://www.zope.com
.. _ZOPE: http://www.zope.org
.. _reStructuredText SourceForge project:
   http://structuredtext.sourceforge.net/
.. _pythondoc: http://starship.python.net/crew/danilo/pythondoc/
.. _StructuredTextNG:
   http://www.zope.org/DevHome/Members/jim/StructuredTextWiki/StructuredTextNG
.. _project history file: ../../../HISTORY.html
.. _PEP 287: ../../peps/pep-0287.html
.. _Docstring Processing System framework: ../../peps/pep-0256.html
.. _comp.lang.python: news:comp.lang.python
.. _Python-dev: http://mail.python.org/pipermail/python-dev/
.. _Docstring Processing System: http://docstring.sourceforge.net/
.. _master PEP repository: http://www.python.org/peps/


..
   Local Variables:
   mode: indented-text
   indent-tabs-mode: nil
   sentence-end-double-space: t
   fill-column: 70
   End:

<template>
  <div class="flex justify-center">
    <div
      class="mx-auto w-full max-w-screen-xl px-4 py-8 sm:px-6 sm:py-12 lg:px-8"
    >
      <!-- 리포트 제목 -->
      <div class="mx-auto max-w-3xl text-center">
        <h2 class="text-3xl font-bold text-gray-900 sm:text-4xl">REPORT</h2>

        <p class="mt-4 text-gray-500 sm:text-xl"></p>
        <p>{{ sampleReportData.address }}에 대한 리포트가 도착했어요!</p>
      </div>

      <!-- 지도 및 도넛 차트 -->
      <div class="flex justify-center mt-6 sm:mt-8 gap-4">
        <div
          class="flex flex-col justify-center items-center rounded-lg bg-blue-50 px-4 py-8 text-center flex-grow basis-1/3 min-h-[250px]"
        >
          <dt class="order-last text-lg font-medium text-gray-500">
            <!-- 지도가 보여지는 지점 현위치 -->
          </dt>
          <div
            id="map"
            ref="mapContainer"
            style="width: 100%; height: 100%; position: relative"
          ></div>
          <dd class="text-4xl font-extrabold text-blue-600 md:text-5xl">
            <!-- 지도 -->
          </dd>
        </div>

        <div
          class="flex flex-col justify-center items-center rounded-lg bg-blue-50 px-4 py-8 text-center flex-grow basis-1/3 min-h-[250px]"
        >
          <dt class="order-last text-lg font-medium text-gray-500"></dt>
          <dd class="text-4xl font-extrabold text-blue-600 md:text-5xl">
            <!-- DonutChart에 score prop 전달 -->
            <DonutChart :score="sampleReportData.totalScore" />
          </dd>
        </div>
      </div>

      <!-- 아코디언 메뉴 -->
      <div class="mx-auto max-w-screen-xl mt-8">
        <!-- Section 1: 안전진단 점수 - 안전 -->
        <div class="faq-card">
          <button @click="togglePanel(1)" class="faq-btn">
            <div class="faq-icon">
              <svg
                class="icon"
                :class="{ 'rotate-180': openPanels.includes(1) }"
                width="17"
                height="10"
                viewBox="0 0 17 10"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M7.28687 8.43257L7.28679 8.43265L7.29496 8.43985C7.62576 8.73124 8.02464 8.86001 8.41472 8.86001C8.83092 8.86001 9.22376 8.69083 9.53447 8.41713L9.53454 8.41721L9.54184 8.41052L15.7631 2.70784L15.7691 2.70231L15.7749 2.69659C16.0981 2.38028 16.1985 1.80579 15.7981 1.41393C15.4803 1.1028 14.9167 1.00854 14.5249 1.38489L8.41472 7.00806L2.29995 1.38063L2.29151 1.37286L2.28271 1.36548C1.93092 1.07036 1.38469 1.06804 1.03129 1.41393L1.01755 1.42738L1.00488 1.44184C0.69687 1.79355 0.695778 2.34549 1.0545 2.69659L1.05999 2.70196L1.06565 2.70717L7.28687 8.43257Z"
                  fill=""
                  stroke=""
                />
              </svg>
            </div>
            <div class="faq-content">
              <h4 class="faq-title">
                1. 안전진단 점수
                <span
                  class="summary"
                  :style="{
                    color:
                      sampleReportData.totalScore < 50
                        ? 'red'
                        : sampleReportData.totalScore < 70
                        ? 'orange'
                        : 'green',
                  }"
                >
                  {{
                    sampleReportData.totalScore < 50
                      ? '위험'
                      : sampleReportData.totalScore < 70
                      ? '경고'
                      : '안전'
                  }}
                </span>
              </h4>
            </div>
          </button>
          <div v-show="openPanels[1]" class="faq-answer">
            <p>
              {{
                sampleReportData.totalScore !== null
                  ? sampleReportData.totalScore < 50
                    ? `안전진단 점수가 ${sampleReportData.totalScore}으로 매우 낮습니다.`
                    : sampleReportData.totalScore < 70
                    ? `안전진단 점수가 ${sampleReportData.totalScore}으로 경고 수준입니다.`
                    : `안전진단 점수가 ${sampleReportData.totalScore}으로 안전하다고 판단됩니다.`
                  : '해당 물건에 대한 데이터가 부족합니다.'
              }}
            </p>
          </div>
        </div>

        <!-- Section 2: 전세가율 -->
        <div class="faq-card">
          <button @click="togglePanel(2)" class="faq-btn">
            <div class="faq-icon">
              <svg
                class="icon"
                :class="{ 'rotate-180': openPanels.includes(2) }"
                width="17"
                height="10"
                viewBox="0 0 17 10"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M7.28687 8.43257L7.28679 8.43265L7.29496 8.43985C7.62576 8.73124 8.02464 8.86001 8.41472 8.86001C8.83092 8.86001 9.22376 8.69083 9.53447 8.41713L9.53454 8.41721L9.54184 8.41052L15.7631 2.70784L15.7691 2.70231L15.7749 2.69659C16.0981 2.38028 16.1985 1.80579 15.7981 1.41393C15.4803 1.1028 14.9167 1.00854 14.5249 1.38489L8.41472 7.00806L2.29995 1.38063L2.29151 1.37286L2.28271 1.36548C1.93092 1.07036 1.38469 1.06804 1.03129 1.41393L1.01755 1.42738L1.00488 1.44184C0.69687 1.79355 0.695778 2.34549 1.0545 2.69659L1.05999 2.70196L1.06565 2.70717L7.28687 8.43257Z"
                  fill=""
                  stroke=""
                />
              </svg>
            </div>
            <div class="faq-content">
              <h4 class="faq-title">
                2. 전세가율
                <span
                  class="summary"
                  :style="{
                    color:
                      sampleReportData.jeonseRate !== null
                        ? sampleReportData.jeonseRate < 70
                          ? 'green'
                          : sampleReportData.jeonseRate < 90
                          ? 'orange'
                          : 'red'
                        : 'black',
                  }"
                >
                  {{
                    sampleReportData.jeonseRate !== null
                      ? sampleReportData.jeonseRate < 60
                        ? '안전'
                        : sampleReportData.jeonseRate < 80
                        ? '경고'
                        : '위험'
                      : '분석불가'
                  }}
                </span>
              </h4>
            </div>
          </button>
          <div v-show="openPanels[2]" class="faq-answer">
            <p>
              {{
                sampleReportData.jeonseRate !== null
                  ? sampleReportData.jeonseRate < 60
                    ? `전세가율이 ${sampleReportData.jeonseRate}%로 안전합니다.`
                    : sampleReportData.jeonseRate < 80
                    ? `전세가율이 ${sampleReportData.jeonseRate}%로 경고 수준입니다.`
                    : `전세가율이 ${sampleReportData.jeonseRate}%로 매우 위험합니다.`
                  : '해당 물건에 대한 데이터 부족합니다.'
              }}
            </p>
          </div>
        </div>

        <!-- Section 3: 소유자 = 계약자 여부 -->
        <div class="faq-card">
          <button @click="togglePanel(3)" class="faq-btn">
            <div class="faq-icon">
              <svg
                class="icon"
                :class="{ 'rotate-180': openPanels.includes(3) }"
                width="17"
                height="10"
                viewBox="0 0 17 10"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M7.28687 8.43257L7.28679 8.43265L7.29496 8.43985C7.62576 8.73124 8.02464 8.86001 8.41472 8.86001C8.83092 8.86001 9.22376 8.69083 9.53447 8.41713L9.53454 8.41721L9.54184 8.41052L15.7631 2.70784L15.7691 2.70231L15.7749 2.69659C16.0981 2.38028 16.1985 1.80579 15.7981 1.41393C15.4803 1.1028 14.9167 1.00854 14.5249 1.38489L8.41472 7.00806L2.29995 1.38063L2.29151 1.37286L2.28271 1.36548C1.93092 1.07036 1.38469 1.06804 1.03129 1.41393L1.01755 1.42738L1.00488 1.44184C0.69687 1.79355 0.695778 2.34549 1.0545 2.69659L1.05999 2.70196L1.06565 2.70717L7.28687 8.43257Z"
                  fill=""
                  stroke=""
                />
              </svg>
            </div>
            <div class="faq-content">
              <h4 class="faq-title">
                3. 소유자와 계약자의 일치 여부
                <span
                  class="summary"
                  :style="{
                    color: !sampleReportData.accordOwner ? 'red' : 'green',
                  }"
                >
                  {{
                    sampleReportData.accordOwner !== null
                      ? sampleReportData.accordOwner
                        ? '동일'
                        : '다름'
                      : '분석불가'
                  }}
                </span>
              </h4>
            </div>
          </button>
          <div v-show="openPanels[3]" class="faq-answer">
            <p>
              {{
                sampleReportData.accordOwner !== null
                  ? sampleReportData.accordOwner != null &&
                    !sampleReportData.accordOwner
                    ? `소유자 ${sampleReportData.ownership}와 계약자 ${sampleReportData.contractName}은 일치하지 않습니다.`
                    : `소유자 ${sampleReportData.ownership}와 계약자 ${sampleReportData.contractName}은 일치합니다.`
                  : '해당 물건에 대한 데이터 부족합니다.'
              }}
            </p>
          </div>
        </div>

        <!-- Section 4: 근저당권 채권 최고액 -->
        <div class="faq-card">
          <button @click="togglePanel(4)" class="faq-btn">
            <div class="faq-icon">
              <svg
                class="icon"
                :class="{ 'rotate-180': openPanels.includes(4) }"
                width="17"
                height="10"
                viewBox="0 0 17 10"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M7.28687 8.43257L7.28679 8.43265L7.29496 8.43985C7.62576 8.73124 8.02464 8.86001 8.41472 8.86001C8.83092 8.86001 9.22376 8.69083 9.53447 8.41713L9.53454 8.41721L9.54184 8.41052L15.7631 2.70784L15.7691 2.70231L15.7749 2.69659C16.0981 2.38028 16.1985 1.80579 15.7981 1.41393C15.4803 1.1028 14.9167 1.00854 14.5249 1.38489L8.41472 7.00806L2.29995 1.38063L2.29151 1.37286L2.28271 1.36548C1.93092 1.07036 1.38469 1.06804 1.03129 1.41393L1.01755 1.42738L1.00488 1.44184C0.69687 1.79355 0.695778 2.34549 1.0545 2.69659L1.05999 2.70196L1.06565 2.70717L7.28687 8.43257Z"
                  fill=""
                  stroke=""
                />
              </svg>
            </div>
            <div class="faq-content">
              <h4 class="faq-title">
                4. 근저당권 채권 최고액
                <span
                  class="summary"
                  :style="{
                    color:
                      sampleReportData.maximumOfBond !== null
                        ? sampleReportData.maximumOfBond > 0
                          ? 'red'
                          : 'green'
                        : 'black',
                  }"
                >
                  {{
                    sampleReportData.maximumOfBond !== null
                      ? sampleReportData.maximumOfBond >= 100000000
                        ? `${Math.floor(
                            sampleReportData.maximumOfBond / 100000000
                          )}억 ${
                            (sampleReportData.maximumOfBond % 100000000) / 10000
                          }만원`
                        : `안전`
                      : '분석불가'
                  }}
                </span>
              </h4>
            </div>
          </button>
          <div v-show="openPanels[4]" class="faq-answer">
            <p>
              {{
                sampleReportData.maximumOfBond !== null
                  ? sampleReportData.maximumOfBond > 0
                    ? `근저당권 채권 최고액이 ${sampleReportData.maximumOfBond}원으로 위험 수준입니다.`
                    : `근저당권으로 잡힌 채권이 없어 안전합니다.`
                  : '해당 물건에 대한 데이터를 불러올 수 없습니다.'
              }}
            </p>
          </div>
        </div>

        <!-- Section 5: 건물의 주용도 -->
        <div class="faq-card">
          <button @click="togglePanel(5)" class="faq-btn">
            <div class="faq-icon">
              <svg
                class="icon"
                :class="{ 'rotate-180': openPanels.includes(5) }"
                width="17"
                height="10"
                viewBox="0 0 17 10"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M7.28687 8.43257L7.28679 8.43265L7.29496 8.43985C7.62576 8.73124 8.02464 8.86001 8.41472 8.86001C8.83092 8.86001 9.22376 8.69083 9.53447 8.41713L9.53454 8.41721L9.54184 8.41052L15.7631 2.70784L15.7691 2.70231L15.7749 2.69659C16.0981 2.38028 16.1985 1.80579 15.7981 1.41393C15.4803 1.1028 14.9167 1.00854 14.5249 1.38489L8.41472 7.00806L2.29995 1.38063L2.29151 1.37286L2.28271 1.36548C1.93092 1.07036 1.38469 1.06804 1.03129 1.41393L1.01755 1.42738L1.00488 1.44184C0.69687 1.79355 0.695778 2.34549 1.0545 2.69659L1.05999 2.70196L1.06565 2.70717L7.28687 8.43257Z"
                  fill=""
                  stroke=""
                />
              </svg>
            </div>
            <div class="faq-content">
              <h4 class="faq-title">
                5. 건물의 주용도
                <span
                  class="summary"
                  :style="{
                    color:
                      sampleReportData.useType !== null || undefined
                        ? sampleReportData.useType &&
                          (sampleReportData.useType.indexOf('주택') >= 0 ||
                            sampleReportData.useType.indexOf('아파트') >= 0 ||
                            sampleReportData.useType.indexOf('주거') >= 0 ||
                            sampleReportData.useType.indexOf('오피스텔') >= 0)
                          ? 'green'
                          : 'red'
                        : 'black',
                  }"
                >
                  {{
                    sampleReportData.useType !== null
                      ? sampleReportData.useType.indexOf('아파트') >= 0 ||
                        sampleReportData.useType.indexOf('주택') >= 0 ||
                        sampleReportData.useType.indexOf('주거') >= 0 ||
                        sampleReportData.useType.indexOf('오피스텔') >= 0
                        ? '안전'
                        : '위험'
                      : '분석불가'
                  }}
                </span>
              </h4>
            </div>
          </button>
          <div v-show="openPanels[5]" class="faq-answer">
            <p>
              {{
                sampleReportData.useType !== null
                  ? sampleReportData.useType == '주거'
                    ? '해당 건물은 주거용 건물입니다.'
                    : `해당 건물은 ${sampleReportData.useType}용 건물입니다.`
                  : '해당 물건에 대한 데이터를 불러올 수 없습니다.'
              }}
            </p>
          </div>
        </div>

        <!-- Section 6: 대지권등기 -->
        <!--<div class="faq-card">
          <button @click="togglePanel(6)" class="faq-btn">
            <div class="faq-icon">
              <svg
                class="icon"
                :class="{ 'rotate-180': openPanels.includes(6) }"
                width="17"
                height="10"
                viewBox="0 0 17 10"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M7.28687 8.43257L7.28679 8.43265L7.29496 8.43985C7.62576 8.73124 8.02464 8.86001 8.41472 8.86001C8.83092 8.86001 9.22376 8.69083 9.53447 8.41713L9.53454 8.41721L9.54184 8.41052L15.7631 2.70784L15.7691 2.70231L15.7749 2.69659C16.0981 2.38028 16.1985 1.80579 15.7981 1.41393C15.4803 1.1028 14.9167 1.00854 14.5249 1.38489L8.41472 7.00806L2.29995 1.38063L2.29151 1.37286L2.28271 1.36548C1.93092 1.07036 1.38469 1.06804 1.03129 1.41393L1.01755 1.42738L1.00488 1.44184C0.69687 1.79355 0.695778 2.34549 1.0545 2.69659L1.05999 2.70196L1.06565 2.70717L7.28687 8.43257Z"
                  fill=""
                  stroke=""
                />
              </svg>
            </div>
            <div class="faq-content">
              <h4 class="faq-title">
                6. 대지권등기
                <span
                  class="summary"
                  :style="{
                    color:
                      sampleReportData.kindOfLandrights !== null
                        ? sampleReportData.kindOfLandrights == '주거'
                          ? 'green'
                          : 'orange'
                        : 'black',
                  }"
                >
                  {{
                    sampleReportData.kindOfLandrights !== null
                      ? sampleReportData.kindOfLandrights > 0
                        ? '안전'
                        : '주의'
                      : '분석불가'
                  }}
                </span>
              </h4>
            </div>
          </button>
          <div v-show="openPanels[6]" class="faq-answer">
            <p>
              {{
                sampleReportData.kindOfLandrights !== null
                  ? sampleReportData.kindOfLandrights > 0
                    ? `해당 물건에 대한 대지권은 ${sampleReportData.kindOfLandrights}㎡ 입니다.`
                    : '해당 물건은 대지에 대한 권리가 없습니다.'
                  : '해당 물건에 대한 데이터를 불러올 수 없습니다.'
              }}
            </p>
          </div>
        </div> -->

        <!-- Section 6: 공동소유/ 단독소유 여부 -->
        <div class="faq-card">
          <button @click="togglePanel(6)" class="faq-btn">
            <div class="faq-icon">
              <svg
                class="icon"
                :class="{ 'rotate-180': openPanels.includes(6) }"
                width="17"
                height="10"
                viewBox="0 0 17 10"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M7.28687 8.43257L7.28679 8.43265L7.29496 8.43985C7.62576 8.73124 8.02464 8.86001 8.41472 8.86001C8.83092 8.86001 9.22376 8.69083 9.53447 8.41713L9.53454 8.41721L9.54184 8.41052L15.7631 2.70784L15.7691 2.70231L15.7749 2.69659C16.0981 2.38028 16.1985 1.80579 15.7981 1.41393C15.4803 1.1028 14.9167 1.00854 14.5249 1.38489L8.41472 7.00806L2.29995 1.38063L2.29151 1.37286L2.28271 1.36548C1.93092 1.07036 1.38469 1.06804 1.03129 1.41393L1.01755 1.42738L1.00488 1.44184C0.69687 1.79355 0.695778 2.34549 1.0545 2.69659L1.05999 2.70196L1.06565 2.70717L7.28687 8.43257Z"
                  fill=""
                  stroke=""
                />
              </svg>
            </div>
            <div class="faq-content">
              <h4 class="faq-title">
                6. 공동소유 단독소유 여부
                <span
                  class="summary"
                  :style="{
                    color:
                      sampleReportData.commonOwner !== null
                        ? sampleReportData.commonOwner.length == 1
                          ? 'green'
                          : 'orange'
                        : 'black',
                  }"
                >
                  {{
                    sampleReportData.commonOwner !== null
                      ? sampleReportData.commonOwner.length == 1
                        ? '안전'
                        : '주의'
                      : '분석불가'
                  }}
                </span>
              </h4>
            </div>
          </button>
          <div v-show="openPanels[6]" class="faq-answer">
            <p>
              {{
                sampleReportData.commonOwner !== null
                  ? sampleReportData.commonOwner === '단독'
                    ? '해당 물건은 단독 소유입니다.'
                    : '해당 물건은 공동 소유입니다.'
                  : '해당 물건에 대한 데이터 부족합니다.'
              }}
            </p>
          </div>
        </div>

        <!-- Section 8: 소유권 변경 횟수 -->
        <div class="faq-card">
          <button @click="togglePanel(8)" class="faq-btn">
            <div class="faq-icon">
              <svg
                class="icon"
                :class="{ 'rotate-180': openPanels.includes(8) }"
                width="17"
                height="10"
                viewBox="0 0 17 10"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M7.28687 8.43257L7.28679 8.43265L7.29496 8.43985C7.62576 8.73124 8.02464 8.86001 8.41472 8.86001C8.83092 8.86001 9.22376 8.69083 9.53447 8.41713L9.53454 8.41721L9.54184 8.41052L15.7631 2.70784L15.7691 2.70231L15.7749 2.69659C16.0981 2.38028 16.1985 1.80579 15.7981 1.41393C15.4803 1.1028 14.9167 1.00854 14.5249 1.38489L8.41472 7.00806L2.29995 1.38063L2.29151 1.37286L2.28271 1.36548C1.93092 1.07036 1.38469 1.06804 1.03129 1.41393L1.01755 1.42738L1.00488 1.44184C0.69687 1.79355 0.695778 2.34549 1.0545 2.69659L1.05999 2.70196L1.06565 2.70717L7.28687 8.43257Z"
                  fill=""
                  stroke=""
                />
              </svg>
            </div>
            <div class="faq-content">
              <h4 class="faq-title">
                8. 소유권 변경 횟수
                <span
                  class="summary"
                  :style="{
                    color:
                      sampleReportData.changeOwnerCount !== null
                        ? sampleReportData.changeOwnerCount < 3
                          ? 'green'
                          : 'orange'
                        : 'black',
                  }"
                >
                  {{
                    sampleReportData.changeOwnerCount !== null
                      ? sampleReportData.changeOwnerCount < 3
                        ? '안전'
                        : `${sampleReportData.changeOwnerCount}회`
                      : '분석불가'
                  }}
                </span>
              </h4>
            </div>
          </button>
          <div v-show="openPanels[8]" class="faq-answer">
            <p>
              {{
                sampleReportData.changeOwnerCount !== null
                  ? sampleReportData.changeOwnerCount < 3
                    ? `해당 물건은 총 ${sampleReportData.changeOwnerCount} 회 소유자가 변경되었습니다.`
                    : `해당 물건은 총 ${sampleReportData.changeOwnerCount} 회 소유자가 변경되었습니다.`
                  : '해당 물건에 대한 데이터가 부족합니다.'
              }}
            </p>
          </div>
        </div>

        <!-- Section 9: 위반건축물 여부 -->
        <div class="faq-card">
          <button @click="togglePanel(9)" class="faq-btn">
            <div class="faq-icon">
              <svg
                class="icon"
                :class="{ 'rotate-180': openPanels.includes(9) }"
                width="17"
                height="10"
                viewBox="0 0 17 10"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M7.28687 8.43257L7.28679 8.43265L7.29496 8.43985C7.62576 8.73124 8.02464 8.86001 8.41472 8.86001C8.83092 8.86001 9.22376 8.69083 9.53447 8.41713L9.53454 8.41721L9.54184 8.41052L15.7631 2.70784L15.7691 2.70231L15.7749 2.69659C16.0981 2.38028 16.1985 1.80579 15.7981 1.41393C15.4803 1.1028 14.9167 1.00854 14.5249 1.38489L8.41472 7.00806L2.29995 1.38063L2.29151 1.37286L2.28271 1.36548C1.93092 1.07036 1.38469 1.06804 1.03129 1.41393L1.01755 1.42738L1.00488 1.44184C0.69687 1.79355 0.695778 2.34549 1.0545 2.69659L1.05999 2.70196L1.06565 2.70717L7.28687 8.43257Z"
                  fill=""
                  stroke=""
                />
              </svg>
            </div>
            <div class="faq-content">
              <h4 class="faq-title">
                9. 위반건축물 여부
                <span
                  class="summary"
                  :style="{
                    color:
                      sampleReportData.violationStructure != null
                        ? !sampleReportData.violationStructure
                          ? 'green'
                          : 'red'
                        : 'black',
                  }"
                >
                  {{
                    sampleReportData.violationStructure != null
                      ? !sampleReportData.violationStructure
                        ? '안전'
                        : '위험'
                      : '분석불가'
                  }}
                </span>
              </h4>
            </div>
          </button>
          <div v-show="openPanels[9]" class="faq-answer">
            <p>
              {{
                sampleReportData.violationStructure != null
                  ? !sampleReportData.violationStructure
                    ? '해당 건물은 위반 건축물이 아닙니다.'
                    : '해당 건물은 위반 건축물입니다.'
                  : '해당 물건에 대한 데이터가 부족합니다.'
              }}
            </p>
          </div>
        </div>

        <!-- Section 10: 전유 부분 (건물 소유 면적) -->
        <div class="faq-card">
          <button @click="togglePanel(10)" class="faq-btn">
            <div class="faq-icon">
              <svg
                class="icon"
                :class="{ 'rotate-180': openPanels.includes(10) }"
                width="17"
                height="10"
                viewBox="0 0 17 10"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M7.28687 8.43257L7.28679 8.43265L7.29496 8.43985C7.62576 8.73124 8.02464 8.86001 8.41472 8.86001C8.83092 8.86001 9.22376 8.69083 9.53447 8.41713L9.53454 8.41721L9.54184 8.41052L15.7631 2.70784L15.7691 2.70231L15.7749 2.69659C16.0981 2.38028 16.1985 1.80579 15.7981 1.41393C15.4803 1.1028 14.9167 1.00854 14.5249 1.38489L8.41472 7.00806L2.29995 1.38063L2.29151 1.37286L2.28271 1.36548C1.93092 1.07036 1.38469 1.06804 1.03129 1.41393L1.01755 1.42738L1.00488 1.44184C0.69687 1.79355 0.695778 2.34549 1.0545 2.69659L1.05999 2.70196L1.06565 2.70717L7.28687 8.43257Z"
                  fill=""
                  stroke=""
                />
              </svg>
            </div>
            <div class="faq-content">
              <h4 class="faq-title">
                10. 전유 부분 (건물 소유 면적)
                <span
                  class="summary"
                  :style="{
                    color:
                      sampleReportData.ownerState != null ? 'blue' : 'black',
                  }"
                >
                  {{
                    sampleReportData.ownerState != null
                      ? `${sampleReportData.ownerState}㎡`
                      : '분석불가'
                  }}
                </span>
              </h4>
            </div>
          </button>
          <div v-show="openPanels[10]" class="faq-answer">
            <p>
              {{
                sampleReportData.ownerState != null
                  ? `해당 물건에서 전유 부분의 건물 소유에 대한 면적은 총 ${sampleReportData.ownerState}㎡ 입니다.`
                  : '해당 물건에 대한 데이터가 부족합니다.'
              }}
            </p>
          </div>
        </div>
      </div>

      <div class="d-flex justify-content-end mt-3">
        <button
          class="btn btn-danger p-3 px-4"
          style="font: 20px bold"
          @click="deleteSelected(sampleNo)"
        >
          삭제
        </button>

        <button
          class="btn btn-primary ml-4 p-3 px-4"
          style="font: 20px bold"
          @click="back"
        >
          목록
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';
import DonutChart from '@/components/DonutChart.vue';
import reportApi from '@/api/reportApi';
import addressApi from '@/api/mapApi';
import { useRouter } from 'vue-router';

// report페이지로 넘어오기
const cr = useRoute();
const router = useRouter();

// MyReport 페이지에서 reportNo 받아오기!!!!!
const sampleNo = cr.params.no;
// 샘플 데이터 <-- reportNo로 바꿔버리자!!!!!!

// 여러 패널의 상태를 관리하는 배열 (각 패널의 열림 상태를 저장)
const openPanels = ref([]);
// 점수 상태를 저장 (필요시 점수 값을 동적으로 변경 가능)
const score = ref(75); // 예: 65점

// 패널을 토글하는 함수 (패널의 인덱스 번호로 제어)
function togglePanel(panelNumber) {
  openPanels.value[panelNumber] = !openPanels.value[panelNumber]; // 해당 패널의 상태만 토글
}

// 3. 소유자와 계약자의 일치 여부

//  서버에서 데이터 가져오는 함수
// 상태 관리
const sampleReportData = ref({
  totalScore: null,
  jeonseRate: null,
  accordOwner: null,
  commonOwner: null,
  contractName: null,
  maximumOfBond: null,
  ownership: null,
  // 다른 필드들도 여기에 추가
});

// 서버에서 데이터를 가져오는 함수
const fetchReportData = async () => {
  try {
    const data = await reportApi.getReportData(sampleNo);
    sampleReportData.value = data; // 가져온 데이터를 상태에 저장
    console.log('sampleReportData.value：', sampleReportData.value);
  } catch (error) {
    console.error('Failed to fetch analysis data:', error);
  }
};

// 선택된 항목 삭제 핸들러
const deleteSelected = async (sampleNo) => {
  if (sampleNo != null) {
    try {
      // 선택된 항목 삭제 로직 추가
      console.log('삭제할 항목:', sampleNo);
      await reportApi.deleteReportData(sampleNo);
      alert('삭제가 완료되었습니다.');

      // 삭제 후 목록 페이지로 이동
      router.push('/myreport');
    } catch (error) {
      console.error('삭제 중 오류 발생:', error);
      alert('삭제 중 오류가 발생했습니다.');
    }
  } else {
    alert('삭제할 항목이 선택되지 않았습니다.');
  }
};

// 목록으로 돌아 가기
const back = () => {
  router.push('/myreport');
};

// 지도 관련된 함수
let map = null;
let marker = null;
const initializeMap = (x, y, doroJuso) => {
  const mapContainer = document.getElementById('map');
  const coords = new kakao.maps.LatLng(y, x);
  const mapOption = {
    center: coords,
    level: 6,
  };

  // 지도 생성
  map = new kakao.maps.Map(mapContainer, mapOption);
  // 마커 생성 및 표시
  marker = new kakao.maps.Marker({
    position: coords,
    map: map,
    image: new kakao.maps.MarkerImage(
      '../../src/assets/marker.svg',
      new kakao.maps.Size(40, 40)
    ),
  });
  const overlayContent = document.createElement('div');
  overlayContent.className = 'customoverlay';
  overlayContent.innerHTML = `<div class="overlayContent"
                                     style="position:relative;
                                            font-size: 18px;
                                            font-weight: bold;
                                            bottom:15px;
                                            background-color:white;"
                                    >${doroJuso}
                                </div>`;
  // 커스텀 오버레이 생성
  const customOverlay = new kakao.maps.CustomOverlay({
    position: coords,
    content: overlayContent,
    clickable: false,
    yAnchor: 2,
    zIndex: 3,
  });
  customOverlay.setMap(map);
  map.setMaxLevel(9);
};

// 상세 보기 토글을 위한 변수 (여러 섹션을 열 수 있도록 배열로 설정)
const openSections = ref([]);

// 토글 함수
const toggleDetails = (no) => {
  const index = openSections.value.indexOf(no);
  if (index === -1) {
    openSections.value.push(no);
  } else {
    openSections.value.splice(index, 1);
  }
};

const moveToSelectedProperty = async () => {
  try {
    const data = await addressApi.getAddressDetails(
      sampleReportData.value.propertyNo
      // sampleNo
    );
    console.log(sampleReportData.value.reportNo);

    if (data && data[0].xcoordinate && data[0].ycoordinate) {
      // 가져온 좌표로 지도 초기화
      initializeMap(
        data[0].xcoordinate, // x 좌표
        data[0].ycoordinate, // y 좌표
        data[0].doroJuso // 도로명 주소
      );
    } else {
      console.error('Invalid coordinates:', data);
    }
  } catch (error) {
    console.error('Failed to fetch address details:', error);
  }
};

// 컴포넌트가 마운트될 때 데이터를 가져옴
onMounted(async () => {
  await fetchReportData(); // 데이터를 먼저 가져옴
  moveToSelectedProperty(); // 데이터가 로드된 후 좌표 이동
});
</script>

<style>
.sec {
  text-align: left;
  padding: 24px; /* 패딩을 크게 */
  font-weight: 900; /* font-black */
  font-size: 1.25rem; /* 글씨 크기 키움 */
  background-color: #e4fdf7; /* Tailwind's gray-100 */
  border-radius: 0.25rem; /* 테두리 살짝 더 둥글게 */
  width: 100%; /* w-full */
  transition: background-color 0.3s ease;
  border: 2px solid #cdcecd; /* 연한 회색 테두리 (사진의 색상) */
}

.sec:hover {
  background-color: #93c5fd; /* Tailwind's blue-300 */
}

.sec:focus {
  background-color: #fde047; /* Tailwind's yellow-300 */
}

.panel {
  overflow: hidden;
}

.summary {
  font-size: 1.1rem;
  font-weight: 700;
  color: #2563eb; /* Tailwind's blue-600 */
}
/* .button {
  margin-top: 10px;
  position: absolute;
  left: 46%;
} */

/* 전체 섹션 스타일 */
.faq-section {
  position: relative;
  padding-top: 120px;
  padding-bottom: 90px;
  background-color: white;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  text-align: center;
}

/* 헤더 섹션 */
.heading {
  text-align: center;
  margin-bottom: 60px;
}

.subheading {
  display: block;
  font-size: 18px;
  font-weight: 600;
  color: #007bff;
  margin-bottom: 20px;
}

.title {
  font-size: 36px;
  font-weight: 700;
  color: #007bff;
  margin-bottom: 20px;
}

.description {
  font-size: 16px;
  color: #666;
}

/* FAQ 카드 */
.faq-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr); /* 2열로 설정 */
  gap: 40px; /* 카드 간 간격을 넓혀줌 */
}

.faq-card {
  padding: 30px; /* 카드 크기 증가 */
  background-color: white;
  border-radius: 10px;
  box-shadow: 0px 20px 95px rgba(201, 203, 204, 0.3);
  text-align: left;
}

.faq-btn {
  display: flex;
  align-items: center;
  width: 100%;
  text-align: left;
  cursor: pointer;
  background: none;
  border: none;
  outline: none;
  padding: 0;
}

.faq-icon {
  margin-right: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 40px;
  height: 40px;
  background-color: #e7f3ff;
  border-radius: 50%;
}

.icon {
  transition: transform 0.3s ease;
}

.rotate-180 {
  transform: rotate(180deg);
}

.faq-content {
  flex-grow: 1;
}

.faq-title {
  font-size: 18px;
  font-weight: 600;
  color: #333;
}

.faq-answer {
  padding-top: 15px;
  font-size: 16px;
  color: #666;
  line-height: 1.6;
}

.summary {
  margin-left: 50px;
}

/* 반응형 디자인 */
@media (max-width: 1024px) {
  .faq-grid {
    grid-template-columns: 1fr; /* 태블릿 이하에서 1열로 변경 */
  }
}
</style>

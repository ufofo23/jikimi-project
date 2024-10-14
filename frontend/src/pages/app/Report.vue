<template>
  <div class="report-wrapper">
    <div class="report-container">
      <div class="report-content">
        <!-- 리포트 제목 -->
        <div class="report-title">
          <h2>REPORT</h2>
          <p>
            <span class="address-text">{{ sampleReportData.address }}</span>
            <span class="report-text">에 대한 리포트가 도착했어요!</span>
          </p>
        </div>

        <!-- 지도 및 도넛 차트 -->
        <div class="map-chart-container">
          <div class="map-container">
            <div id="map" ref="mapContainer"></div>
          </div>
          <div class="chart-container">
            <DonutChart :score="sampleReportData.totalScore" />
          </div>
        </div>

        <!-- 아코디언 메뉴 -->
        <div class="accordion-menu">
          <!-- Section 1: 안전진단 점수 - 안전 -->
          <div
            class="faq-card"
            :class="{
              'faq-card-danger': sampleReportData.totalScore < 70,
              'faq-card-warning':
                sampleReportData.totalScore >= 70 &&
                sampleReportData.totalScore < 85,
              'faq-card-success': sampleReportData.totalScore >= 85,
            }"
          >
            <button @click="togglePanel(1)" class="faq-btn">
              <div class="faq-icon">
                <svg
                  class="icon"
                  :class="{ 'rotate-180': openPanels[1] }"
                  width="17"
                  height="10"
                  viewBox="0 0 17 10"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path
                    d="M7.28687 8.43257L7.29496 8.43985C7.62576 8.73124 8.02464 8.86001 8.41472 8.86001C8.83092 8.86001 9.22376 8.69083 9.53447 8.41713L9.54184 8.41052L15.7631 2.70784C16.0981 2.38028 16.1985 1.80579 15.7981 1.41393C15.4803 1.1028 14.9167 1.00854 14.5249 1.38489L8.41472 7.00806L2.29995 1.38063C1.93092 1.07036 1.38469 1.06804 1.03129 1.41393C0.69687 1.79355 1.0545 2.69659L7.28687 8.43257Z"
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
                        sampleReportData.totalScore < 70
                          ? 'red'
                          : sampleReportData.totalScore < 85
                          ? 'orange'
                          : 'green',
                    }"
                  >
                    {{
                      sampleReportData.totalScore < 70
                        ? '위험'
                        : sampleReportData.totalScore < 85
                        ? '경고'
                        : '안전'
                    }}
                  </span>
                </h4>
              </div>
            </button>
            <div v-show="openPanels[1]" class="faq-answer">
              <span
                v-html="formatTotalScoreMessage(sampleReportData.totalScore)"
              ></span>
            </div>
          </div>

          <!-- Section 2: 전세가율 -->
          <div
            class="faq-card"
            :class="{
              'faq-card-null': sampleReportData.jeonseRate === null,
              'faq-card-danger':
                sampleReportData.jeonseRate !== null &&
                sampleReportData.jeonseRate > 90,
              'faq-card-warning':
                sampleReportData.jeonseRate !== null &&
                sampleReportData.jeonseRate > 80 &&
                sampleReportData.jeonseRate <= 90,
              'faq-card-success':
                sampleReportData.jeonseRate !== null &&
                sampleReportData.jeonseRate <= 80,
            }"
          >
            <button @click="togglePanel(2)" class="faq-btn">
              <div class="faq-icon">
                <svg
                  class="icon"
                  :class="{
                    'rotate-180': openPanels[2],
                  }"
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
              <span
                v-html="formatJeonseRateMessage(sampleReportData.jeonseRate)"
              ></span>
            </div>
          </div>

          <!-- Section 3: 소유자 = 계약자 여부 -->
          <div
            class="faq-card"
            :class="{
              'faq-card-null': sampleReportData.accordOwner === null,
              'faq-card-danger':
                sampleReportData.accordOwner !== null &&
                sampleReportData.accordOwner === false,
              'faq-card-success':
                sampleReportData.accordOwner !== null &&
                sampleReportData.accordOwner === true,
            }"
          >
            <button @click="togglePanel(3)" class="faq-btn">
              <div class="faq-icon">
                <svg
                  class="icon"
                  :class="{
                    'rotate-180': openPanels[3],
                  }"
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
                      color:
                        sampleReportData.accordOwner !== null
                          ? !sampleReportData.accordOwner
                            ? 'red'
                            : 'green'
                          : 'black',
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
              <span
                v-html="formatAccordOwnerMessage(sampleReportData.accordOwner)"
              ></span>
            </div>
          </div>

          <!-- Section 4: 근저당권 채권 최고액 -->
          <div
            class="faq-card"
            :class="{
              'faq-card-null': sampleReportData.maximumOfBond === null,
              'faq-card-danger':
                sampleReportData.maximumOfBond !== null &&
                (sampleReportData.maximumOfBond * 100) /
                  sampleReportData.price >=
                  50,
              'faq-card-warning':
                sampleReportData.maximumOfBond !== null &&
                (sampleReportData.maximumOfBond * 100) /
                  sampleReportData.price <
                  50 &&
                (sampleReportData.maximumOfBond * 100) /
                  sampleReportData.price >
                  30,
              'faq-card-success':
                sampleReportData.maximumOfBond !== null &&
                (sampleReportData.maximumOfBond * 100) /
                  sampleReportData.price <=
                  30,
            }"
          >
            <button @click="togglePanel(4)" class="faq-btn">
              <div class="faq-icon">
                <svg
                  class="icon"
                  :class="{
                    'rotate-180': openPanels[4],
                  }"
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
                          ? (sampleReportData.maximumOfBond * 100) /
                              sampleReportData.price <
                            50
                            ? (sampleReportData.maximumOfBond * 100) /
                                sampleReportData.price <=
                              30
                              ? 'green'
                              : 'yellow'
                            : 'red'
                          : 'black',
                    }"
                  >
                    {{
                      sampleReportData.maximumOfBond !== null
                        ? `${Math.floor(
                            sampleReportData.maximumOfBond / 100000000
                          )}억 ${
                            (sampleReportData.maximumOfBond % 100000000) / 10000
                          }만원`
                        : '분석불가'
                    }}
                  </span>
                </h4>
              </div>
            </button>
            <div v-show="openPanels[4]" class="faq-answer">
              <span
                v-html="
                  formatMaximumOfBondMessage(
                    sampleReportData.maximumOfBond,
                    sampleReportData.price
                  )
                "
              ></span>
            </div>
          </div>

          <!-- Section 5: 건물의 주용도 -->
          <div
            class="faq-card"
            :class="{
              'faq-card-null': sampleReportData.useType === null,
              'faq-card-success':
                sampleReportData.useType &&
                (sampleReportData.useType.includes('주택') ||
                  sampleReportData.useType.includes('아파트') ||
                  sampleReportData.useType.includes('주거') ||
                  sampleReportData.useType.includes('오피스텔')),
            }"
          >
            <button @click="togglePanel(5)" class="faq-btn">
              <div class="faq-icon">
                <svg
                  class="icon"
                  :class="{
                    'rotate-180': openPanels[5],
                  }"
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
                      sampleReportData.useType !== null || undefined
                        ? sampleReportData.useType &&
                          (sampleReportData.useType.indexOf('주택') >= 0 ||
                            sampleReportData.useType.indexOf('아파트') >= 0 ||
                            sampleReportData.useType.indexOf('주거') >= 0 ||
                            sampleReportData.useType.indexOf('오피스텔') >= 0)
                          ? '안전'
                          : '위험'
                        : '분석불가'
                    }}
                  </span>
                </h4>
              </div>
            </button>
            <div v-show="openPanels[5]" class="faq-answer">
              <span
                v-html="formatUseTypeMessage(sampleReportData.useType)"
              ></span>
            </div>
          </div>

          <!-- Section 6: 공동소유/ 단독소유 여부 -->
          <div
            class="faq-card"
            :class="{
              'faq-card-warning': sampleReportData.commonOwner === '공동소유',
              'faq-card-success': sampleReportData.commonOwner === '단독소유',
            }"
          >
            <button @click="togglePanel(6)" class="faq-btn">
              <div class="faq-icon">
                <svg
                  class="icon"
                  :class="{
                    'rotate-180': openPanels[6],
                  }"
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
                  6. 공동소유/ 단독소유 여부
                  <span
                    class="summary"
                    :style="{
                      color:
                        sampleReportData.commonOwner !== null
                          ? sampleReportData.commonOwner == '단독소유'
                            ? 'green'
                            : 'orange'
                          : 'black',
                    }"
                  >
                    {{
                      sampleReportData.commonOwner !== null
                        ? sampleReportData.commonOwner == '단독소유'
                          ? '안전'
                          : '주의'
                        : '분석불가'
                    }}
                  </span>
                </h4>
              </div>
            </button>
            <div v-show="openPanels[6]" class="faq-answer">
              <span
                v-html="formatCommonOwnerMessage(sampleReportData.commonOwner)"
              ></span>
            </div>
          </div>

          <!-- Section 7: 소유권 변경 횟수 -->
          <div
            class="faq-card"
            :class="{
              'faq-card-null': sampleReportData.changeOwnerCount === null,
              'faq-card-danger': sampleReportData.changeOwnerCount > 5,
              'faq-card-warning':
                sampleReportData.changeOwnerCount >= 3 &&
                sampleReportData.changeOwnerCount < 5,
              'faq-card-success': sampleReportData.changeOwnerCount < 3,
            }"
          >
            <button @click="togglePanel(7)" class="faq-btn">
              <div class="faq-icon">
                <svg
                  class="icon"
                  :class="{
                    'rotate-180': openPanels[7],
                  }"
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
                  7. 소유권 변경 횟수
                  <span
                    class="summary"
                    :style="{
                      color:
                        sampleReportData.changeOwnerCount !== null
                          ? sampleReportData.changeOwnerCount < 3
                            ? 'green'
                            : sampleReportData.changeOwnerCount >= 3 &&
                              sampleReportData.changeOwnerCount < 5
                            ? 'orange'
                            : 'red'
                          : 'black',
                    }"
                  >
                    {{
                      sampleReportData.changeOwnerCount !== null
                        ? sampleReportData.changeOwnerCount < 3
                          ? '안전'
                          : sampleReportData.changeOwnerCount < 5
                          ? '주의'
                          : '위험'
                        : '분석불가'
                    }}
                  </span>
                </h4>
              </div>
            </button>
            <div v-show="openPanels[7]" class="faq-answer">
              <span
                v-html="
                  formatChangeOwnerCountMessage(
                    sampleReportData.changeOwnerCount
                  )
                "
              ></span>
            </div>
          </div>

          <!-- Section 8: 위반건축물 여부 -->
          <div
            class="faq-card"
            :class="{
              'faq-card-null': sampleReportData.violationStructure === null,
              'faq-card-danger': sampleReportData.violationStructure === true,
              'faq-card-success': sampleReportData.violationStructure === false,
            }"
          >
            <button @click="togglePanel(8)" class="faq-btn">
              <div class="faq-icon">
                <svg
                  class="icon"
                  :class="{
                    'rotate-180': openPanels[8],
                  }"
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
                  8. 위반건축물 여부
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
            <div v-show="openPanels[8]" class="faq-answer">
              <span
                v-html="
                  formatViolationStructureMessage(
                    sampleReportData.violationStructure
                  )
                "
              ></span>
            </div>
          </div>

          <!-- Section 9: 전유 부분 (건물 소유 면적) -->
          <div class="faq-card" :class="'faq-card-null'">
            <button @click="togglePanel(9)" class="faq-btn">
              <div class="faq-icon">
                <svg
                  class="icon"
                  :class="{
                    'rotate-180': openPanels[9],
                  }"
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
                  9. 전유 부분 (건물 소유 면적)
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
            <div v-show="openPanels[9]" class="faq-answer">
              <span
                v-html="formatOwnerStateMessage(sampleReportData.ownerState)"
              ></span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="button-container">
      <button class="btn btn-danger" @click="deleteSelected(sampleNo)">
        <i class="fas fa-trash-alt"></i> 삭제
      </button>

      <button class="btn btn-primary" @click="back">
        <i class="fas fa-list-ul"></i> 목록
      </button>
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
// 여러 패널의 상태를 관리하는 객체 (각 패널의 열림 상태를 저장)
const openPanels = ref({});
// 점수 상태를 저장 (필요시 점수 값을 동적으로 변경 가능)
const score = ref(75); // 예: 65점

// 패널을 토글하는 함수 (패널의 인덱스 번호로 제어)
function togglePanel(panelNumber) {
  openPanels.value[panelNumber] = !openPanels.value[panelNumber]; // 해당 패널의 상태만 토글
}

//1-9

const formatTotalScoreMessage = (score) => {
  if (score === null) {
    return '해당 물건에 대한 데이터가 <strong>부족</strong>합니다.';
  }
  if (score < 50) {
    return `안전진단 점수가 <strong>${score}</strong>점으로 매우 <strong>낮습니다.</strong>`;
  } else if (score < 70) {
    return `안전진단 점수가 <strong>${score}</strong>점으로 <strong>경고</strong> 수준입니다.`;
  } else {
    return `안전진단 점수가 <strong>${score}</strong>점으로 <strong>안전</strong>하다고 판단됩니다.`;
  }
};

const formatJeonseRateMessage = (rate) => {
  if (rate === null) {
    return '해당 물건에 대한 데이터가 <strong>부족</strong>합니다.';
  }
  if (rate < 60) {
    return `전세가율이 <strong>${rate}%</strong>로 안전합니다.`;
  } else if (rate < 80) {
    return `전세가율이 <strong>${rate}%</strong>로 경고 수준입니다.`;
  } else {
    return `전세가율이 <strong>${rate}%</strong>로 매우 위험합니다.`;
  }
};

const formatAccordOwnerMessage = (accordOwner) => {
  return accordOwner === null
    ? '해당 물건에 대한 데이터가 <strong>부족</strong>합니다.'
    : accordOwner
    ? '소유자와 계약자가 <strong>일치합니다</strong>.'
    : '소유자와 계약자가 <strong>일치하지 않습니다.</strong>';
};

const formatMaximumOfBondMessage = (bond, price) => {
  if (bond === null) {
    return '해당 물건에 대한 데이터를 불러올 수 <strong>없습니다.</strong>';
  }
  const bondRatio = (bond * 100) / price;
  return bondRatio <= 30
    ? '근저당권으로 잡힌 채권이 <strong>없어</strong> 안전합니다.'
    : bondRatio < 50
    ? `근저당권 채권 최고액이 <strong>${Math.floor(bond / 100000000)}억 ${(
        (bond % 100000000) /
        10000
      ).toFixed(0)}만원</strong>으로 주의 수준입니다.`
    : `근저당권 채권 최고액이 <strong>${Math.floor(bond / 100000000)}억 ${(
        (bond % 100000000) /
        10000
      ).toFixed(0)}만원</strong>으로 위험 수준입니다.`;
};

const formatUseTypeMessage = (useType) => {
  if (!useType) {
    // useType이 null 또는 undefined일 경우
    return '해당 물건에 대한 데이터를 불러올 수 <strong>없습니다</strong>.';
  }
  return useType.includes('주거') ||
    useType.includes('아파트') ||
    useType.includes('주택') ||
    useType.includes('오피스텔')
    ? '해당 건물은 <strong>주거용</strong> 건물입니다.'
    : `해당 건물은 <strong>${useType}</strong>용 건물입니다.`;
};

const formatCommonOwnerMessage = (commonOwner) => {
  return commonOwner === null
    ? '해당 물건에 대한 데이터가 <strong>부족</strong>합니다.'
    : commonOwner === '단독소유'
    ? '해당 물건은 <strong>단독 소유</strong>입니다.'
    : '해당 물건은 <strong>공동 소유</strong>입니다.';
};

const formatChangeOwnerCountMessage = (changeOwnerCount) => {
  return changeOwnerCount === null
    ? '해당 물건에 대한 데이터가 <strong>부족</strong>합니다.'
    : `해당 물건은 총 <strong>${changeOwnerCount}</strong>회 소유자가 <strong>변경</strong>되었습니다.`;
};

const formatViolationStructureMessage = (violationStructure) => {
  return violationStructure === null
    ? '해당 물건에 대한 데이터가 <strong>부족</strong>합니다.'
    : violationStructure
    ? '해당 건물은 <strong>위반 건축물</strong>입니다.'
    : '해당 건물은 위반 건축물이 <strong>아닙니다</strong>.';
};

const formatOwnerStateMessage = (ownerState) => {
  return ownerState === null
    ? '해당 물건에 대한 데이터가 <strong>부족</strong>합니다.'
    : `해당 물건에서 전유 부분의 건물 소유에 대한 면적은 총 <strong>${ownerState}㎡</strong> 입니다.`;
};

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
  price: null,
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
  router.push('/mypage/myreport');
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
  overlayContent.innerHTML = `
    <div
      class="overlayContent"
      style="position:relative;
                                            font-size: 18px;
                                            font-weight: bold;
                                            bottom:15px;
                                            background-color:white;"
    >
      ${doroJuso}
    </div>
  `;
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
.faq-answer {
  padding: 0 20px 20px;
  font-size: 28px; /* 글자 크기를 더 크게 키움 */
  color: #666;
}

body {
  font-size: 18px;
  line-height: 1.6;
}

.report-wrapper {
  background-color: #f0f0f0;
  padding: 40px;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.report-container {
  background-color: white;
  border-radius: 15px;
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
  width: 100%;
  max-width: 1200px;
  margin-bottom: 30px;
}

.report-content {
  padding: 40px;
}
.address-text {
  font-size: 40px; /* 글씨 크기를 원하는 크기로 설정 */
  color: blue; /* 파란색으로 설정 */
  font-weight: bold; /* 글씨를 굵게 하고 싶다면 추가 */
}

.report-text {
  font-size: 30px; /* 이 부분도 크기를 키움 */
  color: #333; /* 원하는 색상으로 변경 가능 */
}

.report-title {
  text-align: center;
  margin-bottom: 40px;
}

.report-title h2 {
  font-size: 48px;
  font-weight: bold;
  color: #333;
  margin-bottom: 20px;
}

.report-title p {
  font-size: 24px;
  color: #666;
}

.map-chart-container {
  display: flex;
  justify-content: center;
  gap: 40px;
  margin-bottom: 40px;
}

.map-chart-container,
.accordion-menu {
  width: 100%;
}

.map-container,
.chart-container {
  flex-basis: 48%;
}
/* 지도와 도넛 차트 컨테이너 스타일 수정 */
.map-container,
.chart-container {
  flex-basis: 45%;
  min-height: 300px;
  background-color: #e6f2ff; /* 연한 파랑색 배경 */
  border-radius: 10px;
  padding: 20px;
  justify-content: center;
  display: flex;
  border: 2px solid #b3d9ff; /* 테두리 추가 */
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 약간의 그림자 효과 추가 */
}

#map {
  width: 100%;
  height: 100%;
  position: relative;
}

.faq-card {
  background-color: white;
  border-radius: 10px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  margin-bottom: 20px;
  overflow: hidden;
}

.faq-btn {
  display: flex;
  align-items: center;
  width: 100%;
  padding: 20px;
  background: none;
  border: none;
  cursor: pointer;
  text-align: left;
}

.faq-icon {
  margin-right: 20px;
  transition: transform 0.3s ease;
}

.faq-title {
  font-size: 28px; /* 글자 크기를 더 크게 키움 */
  font-weight: bold;
  color: #333;
}

.summary {
  margin-left: 20px;
  font-size: 24px; /* 글자 크기를 더 크게 키움 */
  font-weight: bold;
}

.faq-answer {
  padding: 0 20px 20px;
  font-size: 28px; /* 글자 크기를 더 크게 키움 */
  color: #666;
}

.button-container {
  display: flex;
  justify-content: center;
  gap: 20px;
  margin-top: 20px;
}

/* 위험, 경고, 안전 등급에 따른 스타일 */
.faq-card-danger {
  background-color: #ffebeb;
  border-left: 5px solid red;
}

.faq-card-null {
  background-color: #f7f7f7; /* 매우 연한 회색 배경 */
  border-left: 5px solid #d9d9d9; /* 밝은 회색 테두리 */
}

.faq-card-warning {
  background-color: #fff4e5;
  border-left: 5px solid orange;
}

.faq-card-success {
  background-color: #e6f7ff;
  border-left: 5px solid green;
}
.button-container {
  display: flex;
  justify-content: center;
  gap: 20px;
  margin-top: 20px;
}

/* 버튼 디자인 및 아이콘 스타일링 */
.btn {
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 12px 24px;
  font-size: 20px;
  font-weight: bold;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.btn i {
  margin-right: 8px;
}

.btn-danger {
  background-color: #ff4d4d;
  color: white;
}

.btn-danger:hover {
  background-color: #e63946;
}

.btn-primary {
  background-color: #4d79ff;
  color: white;
}

.btn-primary:hover {
  background-color: #3a66cc;
}

.rotate-180 {
  transform: rotate(180deg);
}

@media (max-width: 768px) {
  .map-chart-container {
    flex-direction: column;
  }

  .map-container,
  .chart-container {
    flex-basis: 100%;
  }
}
</style>

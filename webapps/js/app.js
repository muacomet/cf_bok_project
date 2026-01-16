const CAFE_WEB_URL = "https://cafe.naver.com/cfbok";
let lastDataHash = "";
let currentZoom = 1.0;

const _util = {
    updateTime: () => {
        const now = new Date();
        const ampm = now.getHours() < 12 ? "오전" : "오후";
        const timeStr = now.toLocaleTimeString('en-GB', { hour12: false });

        // PC 요소 (Elements)
        const ampmPc = document.getElementById('ampm-pc') || document.getElementById('ampm');
        const clockPc = document.getElementById('clock-pc') || document.getElementById('clock');
        if (ampmPc) ampmPc.innerText = ampm;
        if (clockPc) clockPc.innerText = timeStr;

        // 모바일 요소 (Elements)
        const ampmMob = document.getElementById('ampm-mobile');
        const clockMob = document.getElementById('clock-mobile');
        if (ampmMob) ampmMob.innerText = ampm;
        if (clockMob) clockMob.innerText = timeStr;
    },

    getTodayStr: () => {
        const d = new Date();
        return d.getFullYear() + '-' + String(d.getMonth() + 1).padStart(2, '0') + '-' + String(d.getDate()).padStart(2, '0');
    },

    // 데이터 로드 및 UI 업데이트를 처리하는 일반 함수 (Generic load function)
    // renderCallback은 index.html과 index2.html의 서로 다른 UI 갱신 로직을 처리함
    loadData: async (dateStr, renderCallback) => {
        if (!dateStr) return;
        try {
            const res = await fetch(`data.json?t=${Date.now()}`);
            const json = await res.json();
            const dayData = json[dateStr]; // Allow null/undefined to be handled by callback if needed, or default here

            // 불필요한 재렌더링 방지를 위한 해시 체크 (Hash check)
            const currentDataHash = JSON.stringify(dayData || {}) + dateStr;
            if (lastDataHash === currentDataHash) return;
            lastDataHash = currentDataHash;

            const dateText = new Date(dateStr).toLocaleDateString('ko-KR', { year: 'numeric', month: '2-digit', day: '2-digit', weekday: 'long' }).toUpperCase();
            document.querySelectorAll('.display-date').forEach(el => el.innerText = dateText);

            if (renderCallback) {
                renderCallback(dayData || null);
            }

            if (window.lucide) window.lucide.createIcons();

        } catch (err) { console.error(err); }
    }
};

function initCalendar() {
    const dateSel = document.getElementById('date-selector');
    const triggerIds = ['calendar-trigger-pc', 'calendar-trigger-mobile'];
    triggerIds.forEach(id => {
        const el = document.getElementById(id);
        if (el) el.onclick = () => dateSel.showPicker();
    });
    return dateSel;
}

function initQR() {
    if (typeof QRious !== 'undefined') {
        new QRious({
            element: document.getElementById('qrcode-canvas'),
            value: CAFE_WEB_URL,
            size: 600,
            level: 'M',
            padding: 0
        });
    }
}

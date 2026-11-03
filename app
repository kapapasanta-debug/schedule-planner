<!DOCTYPE html>
<html lang="zh-TW">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <title>時程生活手帳 - 貼紙時間規劃表</title>
  <!-- Tailwind CSS -->
  <script src="https://cdn.tailwindcss.com"></script>
  <!-- Lucide Icons -->
  <script src="https://unpkg.com/lucide@latest"></script>
  <!-- Google Fonts: Zen Maru Gothic / Inter -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&family=Zen+Maru+Gothic:wght@400;500;700&display=swap" rel="stylesheet">

  <script>
    tailwind.config = {
      theme: {
        extend: {
          fontFamily: {
            sans: ['"Zen Maru Gothic"', '"Plus Jakarta Sans"', 'sans-serif'],
          },
          colors: {
            cream: {
              50: '#FDFBF7',
              100: '#F7F3E9',
              200: '#EFE8D8',
            },
            work: {
              bg: '#EAF3EC',
              border: '#78A987',
              text: '#22543D',
              badge: '#C6E2CE'
            },
            kids: {
              bg: '#FFF3E6',
              border: '#F6AD55',
              text: '#9C4221',
              badge: '#FEEBC8'
            },
            commute: {
              bg: '#EBF4FF',
              border: '#63B3ED',
              text: '#2B6CB0',
              badge: '#BEE3F8'
            },
            home: {
              bg: '#FFF0F2',
              border: '#F687B3',
              text: '#97266D',
              badge: '#FED7E2'
            }
          },
          boxShadow: {
            'sticker': '2px 3px 0px rgba(0, 0, 0, 0.1)',
            'sticker-hover': '3px 4px 0px rgba(0, 0, 0, 0.15)',
          }
        }
      }
    };
  </script>
  <style>
    body {
      background-color: #F7F3E9;
      -webkit-tap-highlight-color: transparent;
      user-select: none;
    }
    .custom-scrollbar::-webkit-scrollbar {
      height: 4px;
      width: 4px;
    }
    .custom-scrollbar::-webkit-scrollbar-thumb {
      background: #D6CEBE;
      border-radius: 4px;
    }
    .sticker-chip {
      touch-action: manipulation;
    }
  </style>
</head>
<body class="min-h-screen flex flex-col font-sans text-stone-800 bg-cream-100">

  <!-- ================= App Header ================= -->
  <header class="sticky top-0 z-30 bg-[#FDFBF7]/95 backdrop-blur border-b border-stone-200 px-4 py-3 shadow-sm">
    <div class="max-w-4xl mx-auto flex flex-col gap-2.5">
      <div class="flex items-center justify-between">
        <div class="flex items-center gap-2">
          <div class="w-8 h-8 rounded-xl bg-amber-400 text-stone-900 font-bold flex items-center justify-center shadow-sm text-sm">
            貼
          </div>
          <div>
            <h1 class="text-base font-bold text-stone-800 leading-tight">時程手帳規劃表</h1>
            <p class="text-[10px] text-stone-400">貼紙風格 · 日週月排程</p>
          </div>
        </div>

        <div class="flex items-center gap-2">
          <span id="readOnlyBadge" class="hidden text-[10px] bg-rose-100 text-rose-700 px-2 py-0.5 rounded-full font-bold">
            僅供檢視
          </span>
          <button id="openShareModalBtn" class="flex items-center gap-1 bg-stone-800 hover:bg-stone-900 text-white text-xs px-3 py-1.5 rounded-xl font-bold shadow-sm active:scale-95 transition">
            <i data-lucide="share-2" class="w-3.5 h-3.5"></i>
            <span>分享</span>
          </button>
        </div>
      </div>

      <!-- View Switcher Tabs -->
      <div class="grid grid-cols-3 bg-stone-200/70 p-1 rounded-2xl text-xs font-bold text-stone-600">
        <button data-view="day" class="view-tab-btn py-1.5 rounded-xl transition flex items-center justify-center gap-1 bg-white text-stone-900 shadow-sm">
          <i data-lucide="clock" class="w-3.5 h-3.5"></i>
          <span>日檢視</span>
        </button>
        <button data-view="week" class="view-tab-btn py-1.5 rounded-xl transition flex items-center justify-center gap-1 hover:text-stone-900">
          <i data-lucide="calendar-range" class="w-3.5 h-3.5"></i>
          <span>週計劃</span>
        </button>
        <button data-view="month" class="view-tab-btn py-1.5 rounded-xl transition flex items-center justify-center gap-1 hover:text-stone-900">
          <i data-lucide="calendar" class="w-3.5 h-3.5"></i>
          <span>月計劃</span>
        </button>
      </div>
    </div>
  </header>

  <!-- ================= Main Content Container ================= -->
  <main class="flex-1 max-w-4xl w-full mx-auto p-3 pb-36 relative">

      <!-- Active Sticker Banner (Mobile Quick-Stamp Indicator) -->
      <div id="activeStickerBar" class="hidden mb-3 bg-white/90 border border-amber-300 rounded-2xl p-2.5 shadow-sm flex items-center justify-between animate-fadeIn">
        <div class="flex items-center gap-2 text-xs">
          <span class="text-stone-500 font-medium">蓋章模式:</span>
          <span id="activeStickerPreview" class="px-2.5 py-0.5 rounded-lg text-xs font-bold shadow-sticker"></span>
          <span class="text-[11px] text-stone-400">點擊任意時程格即可貼上</span>
        </div>
        <button id="clearActiveStickerBtn" class="text-xs text-stone-400 hover:text-stone-600 p-1">
          <i data-lucide="x" class="w-4 h-4"></i>
        </button>
      </div>

      <!-- VIEW 1: DAY VIEW (6 to 24 pure numbers, 4 quarters of 15 min) -->
      <div id="view-day" class="planner-view">
        <!-- Date Banner Controls -->
        <div class="flex items-center justify-between mb-3 px-1">
          <div class="flex items-center gap-1.5">
            <span class="text-sm font-bold text-stone-800">今日時程 (6 - 24時)</span>
            <span class="text-[11px] bg-stone-200 text-stone-600 px-2 py-0.5 rounded-md font-medium">每15分鐘1格</span>
          </div>
          <button id="clearDayBtn" class="text-xs text-stone-400 hover:text-rose-500 flex items-center gap-1 transition">
            <i data-lucide="trash-2" class="w-3 h-3"></i>
            清空時程
          </button>
        </div>

        <!-- Column headers for 15-minute marks -->
        <div class="bg-white/70 backdrop-blur rounded-2xl border border-stone-200/90 shadow-sm overflow-hidden">
          <div class="grid grid-cols-[54px_1fr_1fr_1fr_1fr] bg-stone-100/90 border-b border-stone-200 text-center py-2 text-[11px] font-bold text-stone-500">
            <div class="border-r border-stone-200/80">時間</div>
            <div class="border-r border-stone-200/50">:00</div>
            <div class="border-r border-stone-200/50">:15</div>
            <div class="border-r border-stone-200/50">:30</div>
            <div>:45</div>
          </div>

          <!-- 6 to 24 Vertical Grid -->
          <div id="dayTimeGrid" class="divide-y divide-stone-200/70">
            <!-- Dynamically generated 6-24 hour rows with 4 slot cells each -->
          </div>
        </div>
      </div>

      <!-- VIEW 2: WEEK VIEW (Dates with separate day columns and slots) -->
      <div id="view-week" class="planner-view hidden">
        <div class="flex items-center justify-between mb-3 px-1">
          <div>
            <h2 class="text-sm font-bold text-stone-800">本週計劃 (11/02 - 11/08)</h2>
            <p class="text-xs text-stone-400">每日獨立分格，點選下方貼紙後點擊任一日放置，或直接新增</p>
          </div>
          <button id="openNewWeekStickerBtn" class="flex items-center gap-1 bg-amber-500 hover:bg-amber-600 text-white text-xs px-2.5 py-1.5 rounded-xl font-bold shadow-sm active:scale-95 transition">
            <i data-lucide="plus" class="w-3.5 h-3.5"></i>
            <span>新增貼紙</span>
          </button>
        </div>

        <!-- 7 Days Grid with Date Headers -->
        <div class="grid grid-cols-1 md:grid-cols-7 gap-2" id="weekGridContainer">
          <!-- Dynamically generated Mon-Sun columns by JS -->
        </div>
      </div>

      <!-- VIEW 3: MONTH VIEW (Monthly Calendar Grid with Date Cells) -->
      <div id="view-month" class="planner-view hidden">
        <div class="flex items-center justify-between mb-3 px-1">
          <div>
            <h2 class="text-sm font-bold text-stone-800">2026年 11月計劃</h2>
            <p class="text-xs text-stone-400">點選貼紙後點擊日期格放置，右上角可獨立新增</p>
          </div>
          <button id="openNewMonthStickerBtn" class="flex items-center gap-1 bg-amber-500 hover:bg-amber-600 text-white text-xs px-2.5 py-1.5 rounded-xl font-bold shadow-sm active:scale-95 transition">
            <i data-lucide="plus" class="w-3.5 h-3.5"></i>
            <span>新增貼紙</span>
          </button>
        </div>

        <div class="bg-white rounded-2xl border border-stone-200 shadow-sm p-2 sm:p-3">
          <!-- Weekday Headers -->
          <div class="grid grid-cols-7 text-center text-xs font-bold text-stone-500 py-1.5 border-b border-stone-100 mb-1">
            <span class="text-rose-500">日</span>
            <span>一</span>
            <span>二</span>
            <span>三</span>
            <span>四</span>
            <span>五</span>
            <span class="text-amber-600">六</span>
          </div>
          <!-- 35 Calendar Cells with Dates -->
          <div id="monthGridContainer" class="grid grid-cols-7 gap-1">
            <!-- Dynamically generated calendar cells by JS -->
          </div>
        </div>
      </div>

    </main>

    <!-- ================= Bottom Floating Sticker Palette (貼紙庫 - Single Clean Instance) ================= -->
    <div id="stickerPaletteDrawer" class="fixed bottom-0 left-0 right-0 z-40 bg-[#FDFBF7] border-t border-stone-300 shadow-[0_-8px_20px_rgba(0,0,0,0.08)] rounded-t-3xl transition-transform duration-300">
      <!-- Drawer Drag Bar / Header -->
      <div class="px-4 pt-2.5 pb-2 flex items-center justify-between cursor-pointer border-b border-stone-200/60" id="drawerHeaderToggle">
        <div class="w-10 h-1 bg-stone-300 rounded-full mx-auto absolute left-1/2 -translate-x-1/2 top-2"></div>
        <div class="flex items-center gap-2 pt-1">
          <span class="text-sm font-bold text-stone-800">行程貼紙庫</span>
          <span class="text-[11px] text-stone-400">(點擊選取蓋章或拖曳，點✕刪除)</span>
        </div>
        <div class="flex items-center gap-2">
          <button id="openNewStickerModalBtn" class="flex items-center gap-1 bg-amber-500 hover:bg-amber-600 text-white text-xs px-2.5 py-1 rounded-xl font-bold shadow-sm active:scale-95 transition">
            <i data-lucide="plus" class="w-3.5 h-3.5"></i>
            新增貼紙
          </button>
          <button id="toggleDrawerBtn" class="text-stone-400 hover:text-stone-600 p-1">
            <i data-lucide="chevron-down" id="drawerChevron" class="w-4 h-4 transition-transform"></i>
          </button>
        </div>
      </div>

      <!-- Sticker Scrollable Categories (Pure Text, No Icons, Deletable) -->
      <div id="paletteContent" class="p-3 max-h-48 overflow-y-auto custom-scrollbar space-y-2.5">
        <!-- Category: 工作 -->
        <div class="flex items-center gap-2 overflow-x-auto pb-1">
          <span class="text-[11px] font-bold text-stone-500 shrink-0 w-10">工作</span>
          <div class="flex items-center gap-2 flex-wrap" id="workStickersContainer"></div>
        </div>

        <!-- Category: 小孩 -->
        <div class="flex items-center gap-2 overflow-x-auto pb-1">
          <span class="text-[11px] font-bold text-stone-500 shrink-0 w-10">小孩</span>
          <div class="flex items-center gap-2 flex-wrap" id="kidsStickersContainer"></div>
        </div>

        <!-- Category: 通勤 -->
        <div class="flex items-center gap-2 overflow-x-auto pb-1">
          <span class="text-[11px] font-bold text-stone-500 shrink-0 w-10">通勤</span>
          <div class="flex items-center gap-2 flex-wrap" id="commuteStickersContainer"></div>
        </div>

        <!-- Category: 家務 -->
        <div class="flex items-center gap-2 overflow-x-auto pb-1">
          <span class="text-[11px] font-bold text-stone-500 shrink-0 w-10">家</span>
          <div class="flex items-center gap-2 flex-wrap" id="homeStickersContainer"></div>
        </div>

        <!-- Category: 自訂 (Custom) -->
        <div class="flex items-center gap-2 overflow-x-auto pb-1" id="customCategoryRow">
          <span class="text-[11px] font-bold text-stone-500 shrink-0 w-10">自訂</span>
          <div class="flex items-center gap-2 flex-wrap" id="customStickersContainer"></div>
        </div>
      </div>
    </div>

  <!-- ================= MODAL 1: SHARE & PERMISSIONS (分享彈窗) ================= -->
  <div id="shareModal" class="fixed inset-0 z-50 bg-black/40 backdrop-blur-sm flex items-end sm:items-center justify-center p-0 sm:p-4 opacity-0 pointer-events-none transition-opacity duration-200">
    <div class="bg-white w-full sm:max-w-md rounded-t-3xl sm:rounded-3xl p-5 shadow-2xl transform translate-y-6 sm:translate-y-0 transition-transform duration-200">
      
      <div class="flex items-center justify-between border-b border-stone-100 pb-3 mb-4">
        <div class="flex items-center gap-2">
          <div class="w-8 h-8 rounded-full bg-amber-100 text-amber-700 flex items-center justify-center">
            <i data-lucide="share-2" class="w-4 h-4"></i>
          </div>
          <h3 class="text-base font-bold text-stone-800">分享此時間規劃表</h3>
        </div>
        <button id="closeShareModalBtn" class="p-1 rounded-lg text-stone-400 hover:text-stone-600 hover:bg-stone-100">
          <i data-lucide="x" class="w-5 h-5"></i>
        </button>
      </div>

      <p class="text-xs text-stone-500 mb-4">
        產生專屬連結分享給伴侶、家人或合作夥伴。請先選擇權限：
      </p>

      <!-- Permissions Selection -->
      <div class="space-y-2 mb-4">
        <!-- Option 1: Read-only -->
        <label class="flex items-start gap-3 p-3 rounded-2xl border border-stone-200 cursor-pointer transition hover:bg-stone-50 bg-stone-50/50 has-[:checked]:border-amber-500 has-[:checked]:bg-amber-50/30">
          <input type="radio" name="sharePermission" value="view" checked class="mt-0.5 text-amber-600 focus:ring-amber-500">
          <div class="flex-1">
            <div class="flex items-center justify-between">
              <span class="text-xs font-bold text-stone-800">僅供檢視 (View only)</span>
              <span class="text-[10px] bg-stone-200 text-stone-600 px-1.5 py-0.5 rounded font-medium">唯讀保護</span>
            </div>
            <p class="text-[11px] text-stone-500 mt-0.5">對方只能查看你的日程、無法新增、移動或刪除貼紙。</p>
          </div>
        </label>

        <!-- Option 2: Can Edit -->
        <label class="flex items-start gap-3 p-3 rounded-2xl border border-stone-200 cursor-pointer transition hover:bg-stone-50 bg-stone-50/50 has-[:checked]:border-amber-500 has-[:checked]:bg-amber-50/30">
          <input type="radio" name="sharePermission" value="edit" class="mt-0.5 text-amber-600 focus:ring-amber-500">
          <div class="flex-1">
            <div class="flex items-center justify-between">
              <span class="text-xs font-bold text-stone-800">允許共同編修 (Can edit)</span>
              <span class="text-[10px] bg-green-100 text-green-700 px-1.5 py-0.5 rounded font-medium">協同合作</span>
            </div>
            <p class="text-[11px] text-stone-500 mt-0.5">對方具備所有編輯權限，能一起貼貼紙、調配行程。</p>
          </div>
        </label>
      </div>

      <!-- Generated Link Box -->
      <div class="mb-4">
        <label class="block text-[11px] font-bold text-stone-500 mb-1">專屬分享連結</label>
        <div class="flex items-center gap-1.5 bg-stone-100 p-2 rounded-xl border border-stone-200">
          <input id="shareLinkInput" type="text" readonly value="https://planner.life/s/user-schedule?mode=view" class="bg-transparent text-xs text-stone-600 flex-1 outline-none font-mono truncate">
          <button id="copyShareLinkBtn" class="bg-stone-800 hover:bg-stone-900 text-white text-xs font-bold px-3 py-1.5 rounded-lg active:scale-95 transition flex items-center gap-1 shrink-0">
            <i data-lucide="copy" class="w-3.5 h-3.5"></i>
            <span>複製連結</span>
          </button>
        </div>
      </div>

      <!-- Action Buttons -->
      <div class="flex gap-2">
        <button id="applyCurrentModeBtn" class="flex-1 py-2.5 rounded-xl border border-stone-300 text-stone-700 text-xs font-bold hover:bg-stone-100 transition">
          切換此裝置預覽
        </button>
        <button id="doneShareBtn" class="flex-1 py-2.5 rounded-xl bg-amber-500 text-white text-xs font-bold hover:bg-amber-600 shadow-md transition">
          完成
        </button>
      </div>
    </div>
  </div>

  <!-- ================= MODAL 2: CUSTOM STICKER CREATION (新增貼紙) ================= -->
  <div id="newStickerModal" class="fixed inset-0 z-50 bg-black/40 backdrop-blur-sm flex items-end sm:items-center justify-center p-0 sm:p-4 opacity-0 pointer-events-none transition-opacity duration-200">
    <div class="bg-white w-full sm:max-w-md rounded-t-3xl sm:rounded-3xl p-5 shadow-2xl transform translate-y-6 sm:translate-y-0 transition-transform duration-200">
      <div class="flex items-center justify-between border-b border-stone-100 pb-3 mb-4">
        <h3 id="newStickerModalTitle" class="text-base font-bold text-stone-800">新增貼紙</h3>
        <button id="closeNewStickerModalBtn" class="p-1 rounded-lg text-stone-400 hover:text-stone-600 hover:bg-stone-100">
          <i data-lucide="x" class="w-5 h-5"></i>
        </button>
      </div>

      <div class="space-y-4">
        <!-- Target Scope (Hidden input to distinguish Library vs Week vs Month) -->
        <input type="hidden" id="targetStickerScope" value="library">

        <!-- Label input -->
        <div>
          <label class="block text-xs font-bold text-stone-600 mb-1">貼紙名稱</label>
          <input id="customStickerTitle" type="text" placeholder="例如：改作業、鋼琴、閱讀" maxlength="12" class="w-full text-xs px-3 py-2 border border-stone-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-amber-500">
        </div>

        <!-- Category Theme / Color -->
        <div>
          <label class="block text-xs font-bold text-stone-600 mb-1.5">選擇分類配色</label>
          <div class="grid grid-cols-4 gap-2">
            <label class="cursor-pointer border-2 border-transparent has-[:checked]:border-stone-800 rounded-xl p-2 text-center bg-work-bg text-work-text flex flex-col items-center">
              <input type="radio" name="customColor" value="work" checked class="hidden">
              <span class="text-xs font-bold">工作綠</span>
            </label>
            <label class="cursor-pointer border-2 border-transparent has-[:checked]:border-stone-800 rounded-xl p-2 text-center bg-kids-bg text-kids-text flex flex-col items-center">
              <input type="radio" name="customColor" value="kids" class="hidden">
              <span class="text-xs font-bold">小孩橘</span>
            </label>
            <label class="cursor-pointer border-2 border-transparent has-[:checked]:border-stone-800 rounded-xl p-2 text-center bg-commute-bg text-commute-text flex flex-col items-center">
              <input type="radio" name="customColor" value="commute" class="hidden">
              <span class="text-xs font-bold">通勤藍</span>
            </label>
            <label class="cursor-pointer border-2 border-transparent has-[:checked]:border-stone-800 rounded-xl p-2 text-center bg-home-bg text-home-text flex flex-col items-center">
              <input type="radio" name="customColor" value="home" class="hidden">
              <span class="text-xs font-bold">家務粉</span>
            </label>
          </div>
        </div>

        <button id="saveCustomStickerBtn" class="w-full mt-2 py-2.5 rounded-xl bg-amber-500 hover:bg-amber-600 text-white text-xs font-bold shadow-md active:scale-98 transition">
          確認新增貼紙
        </button>
      </div>
    </div>
  </div>

  <!-- Toast Notification Message -->
  <div id="toastMessage" class="fixed top-16 left-1/2 -translate-x-1/2 z-50 bg-stone-900/90 text-white text-xs font-bold px-4 py-2 rounded-full shadow-lg pointer-events-none opacity-0 transition-opacity duration-300 flex items-center gap-1.5">
    <i data-lucide="check-circle" class="w-4 h-4 text-emerald-400"></i>
    <span id="toastText">操作成功</span>
  </div>

  <!-- ================= Application Logic ================= -->
  <script>
    // ---------- State Management ----------
    const STATE = {
      currentView: 'day',
      isReadOnly: false,
      activeSticker: null,
      draggedStickerData: null,
      // Library sticker collections (pure text, no icons, deletable)
      stickers: {
        work: [
          { id: 'w1', title: '改作業', category: 'work', bg: 'bg-[#EAF3EC]', border: 'border-[#78A987]', text: 'text-[#22543D]' },
          { id: 'w2', title: '手繪', category: 'work', bg: 'bg-[#EAF3EC]', border: 'border-[#78A987]', text: 'text-[#22543D]' },
          { id: 'w3', title: '電繪', category: 'work', bg: 'bg-[#EAF3EC]', border: 'border-[#78A987]', text: 'text-[#22543D]' },
        ],
        kids: [
          { id: 'k1', title: '鋼琴', category: 'kids', bg: 'bg-[#FFF3E6]', border: 'border-[#F6AD55]', text: 'text-[#9C4221]' },
          { id: 'k2', title: '足球', category: 'kids', bg: 'bg-[#FFF3E6]', border: 'border-[#F6AD55]', text: 'text-[#9C4221]' },
          { id: 'k3', title: '網球', category: 'kids', bg: 'bg-[#FFF3E6]', border: 'border-[#F6AD55]', text: 'text-[#9C4221]' },
          { id: 'k4', title: '滑板', category: 'kids', bg: 'bg-[#FFF3E6]', border: 'border-[#F6AD55]', text: 'text-[#9C4221]' },
        ],
        commute: [
          { id: 'c1', title: '車子', category: 'commute', bg: 'bg-[#EBF4FF]', border: 'border-[#63B3ED]', text: 'text-[#2B6CB0]' },
          { id: 'c2', title: '摩托車', category: 'commute', bg: 'bg-[#EBF4FF]', border: 'border-[#63B3ED]', text: 'text-[#2B6CB0]' },
        ],
        home: [
          { id: 'h1', title: '煮飯', category: 'home', bg: 'bg-[#FFF0F2]', border: 'border-[#F687B3]', text: 'text-[#97266D]' },
          { id: 'h2', title: '家務', category: 'home', bg: 'bg-[#FFF0F2]', border: 'border-[#F687B3]', text: 'text-[#97266D]' },
        ],
        custom: []
      },
      // Day schedule map: "06:00" -> sticker
      daySchedule: {},
      // Week plan slots: "day_0" to "day_6" -> array of stickers
      weekSchedule: {
        '0': [{ id: 'w1_seed', title: '改作業', bg: 'bg-[#EAF3EC]', border: 'border-[#78A987]', text: 'text-[#22543D]' }],
        '2': [{ id: 'w2_seed', title: '足球', bg: 'bg-[#FFF3E6]', border: 'border-[#F6AD55]', text: 'text-[#9C4221]' }],
        '4': [{ id: 'w3_seed', title: '電繪', bg: 'bg-[#EAF3EC]', border: 'border-[#78A987]', text: 'text-[#22543D]' }],
      },
      // Month schedule: date string "2026-11-04" -> array of stickers
      monthSchedule: {
        '2026-11-03': [{ id: 'm1_seed', title: '鋼琴', bg: 'bg-[#FFF3E6]', border: 'border-[#F6AD55]', text: 'text-[#9C4221]' }],
        '2026-11-12': [{ id: 'm2_seed', title: '網球', bg: 'bg-[#FFF3E6]', border: 'border-[#F6AD55]', text: 'text-[#9C4221]' }],
        '2026-11-20': [{ id: 'm3_seed', title: '煮飯', bg: 'bg-[#FFF0F2]', border: 'border-[#F687B3]', text: 'text-[#97266D]' }]
      }
    };

    // Color mapper for custom items
    const COLOR_THEMES = {
      work: { bg: 'bg-[#EAF3EC]', border: 'border-[#78A987]', text: 'text-[#22543D]' },
      kids: { bg: 'bg-[#FFF3E6]', border: 'border-[#F6AD55]', text: 'text-[#9C4221]' },
      commute: { bg: 'bg-[#EBF4FF]', border: 'border-[#63B3ED]', text: 'text-[#2B6CB0]' },
      home: { bg: 'bg-[#FFF0F2]', border: 'border-[#F687B3]', text: 'text-[#97266D]' }
    };

    // Initialize UI on Load
    window.addEventListener('DOMContentLoaded', () => {
      lucide.createIcons();
      buildDayViewGrid();
      buildWeekViewGrid();
      buildMonthViewGrid();
      renderAllPaletteCategories();
      setupEventListeners();
      seedSampleSchedule();
    });

    // ---------- Seed Initial Day Stickers ----------
    function seedSampleSchedule() {
      STATE.daySchedule['07:30'] = { ...STATE.stickers.commute[0] };
      STATE.daySchedule['08:00'] = { ...STATE.stickers.work[0] };
      STATE.daySchedule['10:15'] = { ...STATE.stickers.work[2] };
      STATE.daySchedule['17:30'] = { ...STATE.stickers.kids[1] };
      STATE.daySchedule['19:00'] = { ...STATE.stickers.home[0] };
      renderDayView();
    }

    // ---------- Build Day View (Numbers vertically centered between horizontal divider lines) ----------
    function buildDayViewGrid() {
      const grid = document.getElementById('dayTimeGrid');
      grid.innerHTML = '';
      const quarters = ['00', '15', '30', '45'];

      // 6 to 24 pure numbers, placed neatly at the top of each row right on the upper line
      for (let h = 6; h <= 24; h++) {
        const hourStr = h < 10 ? `0${h}` : `${h}`;
        const row = document.createElement('div');
        row.className = 'grid grid-cols-[54px_1fr_1fr_1fr_1fr] min-h-[50px] items-stretch text-xs hover:bg-stone-50/70 transition-colors border-b border-stone-200/70 last:border-b-0 relative';

        // Hour Label column: Single clean number aligned to the top edge (aligned with the upper line)
        const labelCol = document.createElement('div');
        labelCol.className = 'border-r border-stone-200/80 bg-stone-50/60 flex items-start justify-center pt-1 font-bold text-stone-600 text-xs select-none relative';
        labelCol.innerHTML = `<span class="-translate-y-1 text-xs font-semibold text-stone-600 bg-stone-50/90 px-1 rounded">${h}</span>`;
        row.appendChild(labelCol);

        // 4 x 15-minute slot columns
        quarters.forEach((q, idx) => {
          const timeSlotKey = `${hourStr}:${q}`;
          const cell = document.createElement('div');
          cell.className = `day-slot-cell border-r border-stone-200/50 p-1 flex items-center justify-center relative transition-colors ${idx === 3 ? 'border-r-0' : ''}`;
          cell.dataset.timeSlot = timeSlotKey;

          setupDropTarget(cell, (data) => {
            placeStickerInDaySlot(timeSlotKey, data);
          });

          cell.addEventListener('click', (e) => {
            handleDaySlotTap(timeSlotKey, e);
          });

          row.appendChild(cell);
        });

        grid.appendChild(row);
      }
    }

    // ---------- Render Day View Stickers ----------
    function renderDayView() {
      document.querySelectorAll('.day-slot-cell').forEach(cell => {
        cell.innerHTML = '';
      });

      Object.entries(STATE.daySchedule).forEach(([timeSlot, sticker]) => {
        if (!sticker) return;
        const cell = document.querySelector(`.day-slot-cell[data-time-slot="${timeSlot}"]`);
        if (!cell) return;

        const badge = createStickerElement(sticker, () => {
          if (STATE.isReadOnly) return;
          delete STATE.daySchedule[timeSlot];
          renderDayView();
          showToast('已移除時程貼紙');
        }, 'compact');

        cell.appendChild(badge);
      });
    }

    // ---------- Build Week View with Dates & Separate Columns ----------
    const WEEK_DAYS = [
      { name: '週一', date: '11/02', isToday: false },
      { name: '週二', date: '11/03', isToday: true },
      { name: '週三', date: '11/04', isToday: false },
      { name: '週四', date: '11/05', isToday: false },
      { name: '週五', date: '11/06', isToday: false },
      { name: '週六', date: '11/07', isToday: false },
      { name: '週日', date: '11/08', isToday: false },
    ];

    function buildWeekViewGrid() {
      const container = document.getElementById('weekGridContainer');
      if (!container) return;
      container.innerHTML = '';

      WEEK_DAYS.forEach((day, index) => {
        const col = document.createElement('div');
        col.className = `bg-white rounded-2xl border ${day.isToday ? 'border-amber-400 ring-2 ring-amber-200/60' : 'border-stone-200'} shadow-sm flex flex-col overflow-hidden`;

        // Date Header
        const header = document.createElement('div');
        header.className = `p-2.5 text-center border-b ${day.isToday ? 'bg-amber-50 border-amber-200' : 'bg-stone-50 border-stone-200'}`;
        header.innerHTML = `
          <div class="text-xs font-bold ${day.isToday ? 'text-amber-700' : 'text-stone-700'}">${day.name}</div>
          <div class="text-[11px] font-semibold ${day.isToday ? 'text-amber-600' : 'text-stone-400'}">${day.date}</div>
        `;
        col.appendChild(header);

        // Sticker Drop / Placement Area
        const body = document.createElement('div');
        body.className = 'p-2 flex-1 min-h-[140px] flex flex-col gap-1.5 content-start bg-[#FDFBF7]/50';
        body.dataset.weekDayIndex = index;

        setupDropTarget(body, (stickerData) => {
          addWeekSticker(index, stickerData);
        });

        body.addEventListener('click', (e) => {
          if (e.target.closest('.sticker-chip') || STATE.isReadOnly) return;
          if (STATE.activeSticker) {
            addWeekSticker(index, { ...STATE.activeSticker });
          }
        });

        col.appendChild(body);
        container.appendChild(col);
      });

      renderWeekStickers();
    }

    function addWeekSticker(dayIndex, stickerData) {
      if (!STATE.weekSchedule[dayIndex]) {
        STATE.weekSchedule[dayIndex] = [];
      }
      STATE.weekSchedule[dayIndex].push({
        ...stickerData,
        id: 'week_' + Date.now() + Math.random().toString(36).substring(4)
      });
      renderWeekStickers();
      showToast(`已新增至 ${WEEK_DAYS[dayIndex].name}`);
    }

    function renderWeekStickers() {
      document.querySelectorAll('[data-week-day-index]').forEach(body => {
        body.innerHTML = '';
        const dayIdx = body.dataset.weekDayIndex;
        const stickers = STATE.weekSchedule[dayIdx] || [];

        if (stickers.length === 0) {
          const emptyHint = document.createElement('span');
          emptyHint.className = 'text-[10px] text-stone-300 italic text-center py-2 select-none';
          emptyHint.textContent = '點擊貼上';
          body.appendChild(emptyHint);
          return;
        }

        stickers.forEach((sticker, sIdx) => {
          const badge = createStickerElement(sticker, () => {
            if (STATE.isReadOnly) return;
            STATE.weekSchedule[dayIdx].splice(sIdx, 1);
            renderWeekStickers();
            showToast('已刪除貼紙');
          }, 'normal');
          body.appendChild(badge);
        });
      });
    }

    // ---------- Build Month View with Calendar Grid & Date Cells ----------
    function buildMonthViewGrid() {
      const container = document.getElementById('monthGridContainer');
      if (!container) return;
      container.innerHTML = '';

      // November 2026: Nov 1st is Sunday (day 0), 30 days total
      const totalDays = 30;
      const startDayOfWeek = 0; // Sunday

      for (let i = 1; i <= totalDays; i++) {
        const dateStr = `2026-11-${i < 10 ? '0' + i : i}`;
        const isToday = i === 3;

        const cell = document.createElement('div');
        cell.className = `min-h-[72px] sm:min-h-[88px] p-1 rounded-xl border ${isToday ? 'border-amber-400 bg-amber-50/30' : 'border-stone-100 bg-stone-50/40'} flex flex-col justify-between transition-colors`;
        cell.dataset.monthDate = dateStr;

        // Date Number
        const header = document.createElement('div');
        header.className = 'flex items-center justify-between px-1';
        header.innerHTML = `
          <span class="text-[11px] font-bold ${isToday ? 'text-amber-600 bg-amber-200/80 px-1.5 rounded-full' : 'text-stone-600'}">${i}</span>
          ${isToday ? '<span class="text-[9px] text-amber-600 font-bold hidden sm:inline">今日</span>' : ''}
        `;
        cell.appendChild(header);

        // Stickers Slot container
        const stickersArea = document.createElement('div');
        stickersArea.className = 'flex flex-col gap-1 overflow-y-auto custom-scrollbar flex-1 pt-1';
        stickersArea.dataset.monthSlot = dateStr;

        setupDropTarget(cell, (stickerData) => {
          addMonthSticker(dateStr, stickerData);
        });

        cell.addEventListener('click', (e) => {
          if (e.target.closest('.sticker-chip') || STATE.isReadOnly) return;
          if (STATE.activeSticker) {
            addMonthSticker(dateStr, { ...STATE.activeSticker });
          }
        });

        cell.appendChild(stickersArea);
        container.appendChild(cell);
      }

      renderMonthStickers();
    }

    function addMonthSticker(dateStr, stickerData) {
      if (!STATE.monthSchedule[dateStr]) {
        STATE.monthSchedule[dateStr] = [];
      }
      STATE.monthSchedule[dateStr].push({
        ...stickerData,
        id: 'month_' + Date.now() + Math.random().toString(36).substring(4)
      });
      renderMonthStickers();
      showToast(`已貼上至 ${dateStr}`);
    }

    function renderMonthStickers() {
      document.querySelectorAll('[data-month-slot]').forEach(area => {
        area.innerHTML = '';
        const dateStr = area.dataset.monthSlot;
        const stickers = STATE.monthSchedule[dateStr] || [];

        stickers.forEach((sticker, sIdx) => {
          const badge = createStickerElement(sticker, () => {
            if (STATE.isReadOnly) return;
            STATE.monthSchedule[dateStr].splice(sIdx, 1);
            renderMonthStickers();
            showToast('已刪除貼紙');
          }, 'compact');
          area.appendChild(badge);
        });
      });
    }

    // ---------- Create Sticker Element (Pure text, no icon, removable) ----------
    function createStickerElement(sticker, onDelete, variant = 'normal') {
      const chip = document.createElement('div');
      const isCompact = variant === 'compact';

      chip.className = `sticker-chip sticker-placed inline-flex items-center gap-1 rounded-xl shadow-sticker border font-bold cursor-grab active:cursor-grabbing transition-all select-none ${sticker.bg} ${sticker.border} ${sticker.text} ${
        isCompact ? 'px-1.5 py-0.5 text-[10px] w-full justify-between' : 'px-2 py-1 text-xs justify-between w-full'
      }`;

      chip.draggable = !STATE.isReadOnly;

      // Pure text title (NO icon)
      const content = document.createElement('span');
      content.className = 'truncate pointer-events-none';
      content.textContent = sticker.title;
      chip.appendChild(content);

      // Delete button
      if (!STATE.isReadOnly && onDelete) {
        const delBtn = document.createElement('button');
        delBtn.type = 'button';
        delBtn.className = 'text-stone-400 hover:text-rose-600 ml-1 p-0.5 rounded hover:bg-black/5 flex items-center justify-center shrink-0 text-xs font-bold leading-none';
        delBtn.innerHTML = '✕';
        delBtn.title = '刪除';
        delBtn.addEventListener('click', (e) => {
          e.stopPropagation();
          onDelete();
        });
        chip.appendChild(delBtn);
      }

      // Drag listener
      chip.addEventListener('dragstart', (e) => {
        if (STATE.isReadOnly) {
          e.preventDefault();
          return;
        }
        STATE.draggedStickerData = sticker;
        e.dataTransfer.setData('application/json', JSON.stringify(sticker));
      });

      chip.addEventListener('dragend', () => {
        STATE.draggedStickerData = null;
      });

      return chip;
    }

    // ---------- Drag & Drop Handlers ----------
    function setupDropTarget(el, onDropCallback) {
      el.addEventListener('dragover', (e) => {
        if (STATE.isReadOnly) return;
        e.preventDefault();
        el.classList.add('bg-amber-100/60');
      });

      el.addEventListener('dragleave', () => {
        el.classList.remove('bg-amber-100/60');
      });

      el.addEventListener('drop', (e) => {
        if (STATE.isReadOnly) return;
        e.preventDefault();
        el.classList.remove('bg-amber-100/60');

        let data = STATE.draggedStickerData;
        if (!data) {
          try {
            const raw = e.dataTransfer.getData('application/json');
            if (raw) data = JSON.parse(raw);
          } catch (err) {
            console.error(err);
          }
        }

        if (data) {
          onDropCallback(data);
          showToast(`已貼上「${data.title}」`);
        }
      });
    }

    function placeStickerInDaySlot(slotKey, stickerData) {
      if (STATE.isReadOnly) return;
      STATE.daySchedule[slotKey] = { ...stickerData };
      renderDayView();
    }

    function handleDaySlotTap(timeSlotKey, event) {
      if (STATE.isReadOnly) return;
      if (STATE.activeSticker) {
        placeStickerInDaySlot(timeSlotKey, { ...STATE.activeSticker });
        showToast(`已貼上「${STATE.activeSticker.title}」`);
      } else if (STATE.daySchedule[timeSlotKey]) {
        delete STATE.daySchedule[timeSlotKey];
        renderDayView();
        showToast('已清除該時段貼紙');
      }
    }

    // ---------- Palette Rendering with Add & Delete Support ----------
    function renderAllPaletteCategories() {
      ['work', 'kids', 'commute', 'home', 'custom'].forEach(cat => {
        renderPaletteCategory(cat);
      });
    }

    function renderPaletteCategory(category) {
      const containerId = `${category}StickersContainer`;
      const container = document.getElementById(containerId);
      if (!container) return;
      container.innerHTML = '';

      const list = STATE.stickers[category] || [];
      if (list.length === 0 && category === 'custom') {
        container.innerHTML = '<span class="text-[11px] text-stone-400 italic">尚無自訂貼紙</span>';
        return;
      }

      list.forEach((item, index) => {
        const chip = document.createElement('div');
        chip.className = `sticker-chip inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl shadow-sticker border text-xs font-bold cursor-pointer select-none active:scale-95 transition-all ${item.bg} ${item.border} ${item.text}`;
        chip.draggable = !STATE.isReadOnly;

        // Pure text title (No icon)
        const textSpan = document.createElement('span');
        textSpan.textContent = item.title;
        chip.appendChild(textSpan);

        // Delete button for ANY sticker in library
        if (!STATE.isReadOnly) {
          const delBtn = document.createElement('button');
          delBtn.type = 'button';
          delBtn.className = 'text-stone-400 hover:text-rose-600 ml-1 p-0.5 rounded-full hover:bg-black/5 flex items-center justify-center shrink-0 text-xs font-bold leading-none';
          delBtn.innerHTML = '✕';
          delBtn.title = '刪除此貼紙';
          delBtn.addEventListener('click', (e) => {
            e.stopPropagation();
            STATE.stickers[category].splice(index, 1);
            if (STATE.activeSticker && STATE.activeSticker.id === item.id) {
              clearActiveSticker();
            }
            renderPaletteCategory(category);
            showToast(`已從貼紙庫刪除「${item.title}」`);
          });
          chip.appendChild(delBtn);
        }

        // Tap to select as active stamping sticker
        chip.addEventListener('click', (e) => {
          e.stopPropagation();
          setActiveSticker(item);
        });

        // Drag handlers
        chip.addEventListener('dragstart', (e) => {
          if (STATE.isReadOnly) {
            e.preventDefault();
            return;
          }
          STATE.draggedStickerData = item;
          e.dataTransfer.setData('application/json', JSON.stringify(item));
        });

        chip.addEventListener('dragend', () => {
          STATE.draggedStickerData = null;
        });

        container.appendChild(chip);
      });
    }

    function setActiveSticker(item) {
      STATE.activeSticker = item;
      const bar = document.getElementById('activeStickerBar');
      const preview = document.getElementById('activeStickerPreview');

      bar.classList.remove('hidden');
      preview.className = `px-2.5 py-0.5 rounded-lg text-xs font-bold border ${item.bg} ${item.border} ${item.text}`;
      preview.textContent = item.title;
      showToast(`已選取「${item.title}」，點擊目標格貼上`);
    }

    function clearActiveSticker() {
      STATE.activeSticker = null;
      document.getElementById('activeStickerBar').classList.add('hidden');
    }

    // ---------- Setup Event Listeners ----------
    function setupEventListeners() {
      // 1. View Switcher Tabs
      const viewButtons = document.querySelectorAll('.view-tab-btn');
      viewButtons.forEach(btn => {
        btn.addEventListener('click', () => {
          const targetView = btn.dataset.view;
          switchView(targetView);
        });
      });

      // 2. Clear Day Button
      document.getElementById('clearDayBtn').addEventListener('click', () => {
        if (STATE.isReadOnly) return;
        STATE.daySchedule = {};
        renderDayView();
        showToast('時程已全數清空');
      });

      // 3. Clear Active Sticker
      document.getElementById('clearActiveStickerBtn').addEventListener('click', clearActiveSticker);

      // 4. Drawer Toggle (Minimize / Maximize)
      let drawerOpen = true;
      const paletteContent = document.getElementById('paletteContent');
      const drawerChevron = document.getElementById('drawerChevron');
      const toggleDrawer = () => {
        drawerOpen = !drawerOpen;
        if (drawerOpen) {
          paletteContent.classList.remove('hidden');
          drawerChevron.style.transform = 'rotate(0deg)';
        } else {
          paletteContent.classList.add('hidden');
          drawerChevron.style.transform = 'rotate(180deg)';
        }
      };
      document.getElementById('toggleDrawerBtn').addEventListener('click', (e) => {
        e.stopPropagation();
        toggleDrawer();
      });
      document.getElementById('drawerHeaderToggle').addEventListener('click', (e) => {
        if (e.target.closest('button')) return;
        toggleDrawer();
      });

      // 5. Share Modal Handlers
      setupShareModalHandlers();

      // 6. Custom Sticker Modal Handlers (Library, Week, Month)
      setupNewStickerModalHandlers();
    }

    function switchView(viewName) {
      STATE.currentView = viewName;

      // Update Tab Styles
      document.querySelectorAll('.view-tab-btn').forEach(btn => {
        const isActive = btn.dataset.view === viewName;
        if (isActive) {
          btn.className = 'view-tab-btn py-1.5 rounded-xl transition flex items-center justify-center gap-1 bg-white text-stone-900 shadow-sm font-bold';
        } else {
          btn.className = 'view-tab-btn py-1.5 rounded-xl transition flex items-center justify-center gap-1 hover:text-stone-900 font-bold';
        }
      });

      // Show / Hide View Sections
      document.querySelectorAll('.planner-view').forEach(viewEl => {
        viewEl.classList.add('hidden');
      });
      document.getElementById(`view-${viewName}`).classList.remove('hidden');
    }

    // ---------- Modal: Share & Permissions ----------
    function setupShareModalHandlers() {
      const shareModal = document.getElementById('shareModal');
      const openBtn = document.getElementById('openShareModalBtn');
      const closeBtn = document.getElementById('closeShareModalBtn');
      const doneBtn = document.getElementById('doneShareBtn');
      const copyBtn = document.getElementById('copyShareLinkBtn');
      const applyBtn = document.getElementById('applyCurrentModeBtn');
      const shareInput = document.getElementById('shareLinkInput');
      const radios = document.querySelectorAll('input[name="sharePermission"]');

      const openModal = () => {
        shareModal.classList.remove('opacity-0', 'pointer-events-none');
        updateShareLink();
      };

      const closeModal = () => {
        shareModal.classList.add('opacity-0', 'pointer-events-none');
      };

      const updateShareLink = () => {
        const selectedPerm = document.querySelector('input[name="sharePermission"]:checked').value;
        const url = `${window.location.origin}${window.location.pathname}?token=shared_${Math.random().toString(36).substring(7)}&mode=${selectedPerm}`;
        shareInput.value = url;
      };

      openBtn.addEventListener('click', openModal);
      closeBtn.addEventListener('click', closeModal);
      doneBtn.addEventListener('click', closeModal);
      shareModal.addEventListener('click', (e) => {
        if (e.target === shareModal) closeModal();
      });

      radios.forEach(radio => {
        radio.addEventListener('change', updateShareLink);
      });

      copyBtn.addEventListener('click', () => {
        shareInput.select();
        shareInput.setSelectionRange(0, 99999);
        try {
          document.execCommand('copy');
          showToast('分享連結已複製！');
        } catch (err) {
          showToast('請手動複製連結');
        }
      });

      applyBtn.addEventListener('click', () => {
        const selectedPerm = document.querySelector('input[name="sharePermission"]:checked').value;
        setReadOnlyMode(selectedPerm === 'view');
        closeModal();
      });
    }

    function setReadOnlyMode(readOnly) {
      STATE.isReadOnly = readOnly;
      const badge = document.getElementById('readOnlyBadge');
      const clearDayBtn = document.getElementById('clearDayBtn');
      const drawer = document.getElementById('stickerPaletteDrawer');

      if (readOnly) {
        badge.classList.remove('hidden');
        clearDayBtn.classList.add('opacity-30', 'pointer-events-none');
        drawer.classList.add('opacity-40', 'pointer-events-none');
        clearActiveSticker();
        showToast('已切換為「僅供檢視」模式');
      } else {
        badge.classList.add('hidden');
        clearDayBtn.classList.remove('opacity-30', 'pointer-events-none');
        drawer.classList.remove('opacity-40', 'pointer-events-none');
        showToast('已啟用「允許編修」模式');
      }

      renderDayView();
      renderAllPaletteCategories();
      renderWeekStickers();
      renderMonthStickers();
    }

    // ---------- Modal: Create Sticker (Library / Week / Month) ----------
    function setupNewStickerModalHandlers() {
      const modal = document.getElementById('newStickerModal');
      const openLibraryBtn = document.getElementById('openNewStickerModalBtn');
      const openWeekBtn = document.getElementById('openNewWeekStickerBtn');
      const openMonthBtn = document.getElementById('openNewMonthStickerBtn');
      const closeBtn = document.getElementById('closeNewStickerModalBtn');
      const saveBtn = document.getElementById('saveCustomStickerBtn');
      const titleInput = document.getElementById('customStickerTitle');
      const modalTitle = document.getElementById('newStickerModalTitle');
      const targetScope = document.getElementById('targetStickerScope');

      const openModalFor = (scope, headerText) => {
        targetScope.value = scope;
        modalTitle.textContent = headerText;
        titleInput.value = '';
        modal.classList.remove('opacity-0', 'pointer-events-none');
        titleInput.focus();
      };

      const closeModal = () => {
        modal.classList.add('opacity-0', 'pointer-events-none');
      };

      openLibraryBtn.addEventListener('click', () => openModalFor('library', '新增自訂貼紙至貼紙庫'));
      openWeekBtn.addEventListener('click', () => openModalFor('week', '新增本週貼紙'));
      openMonthBtn.addEventListener('click', () => openModalFor('month', '新增本月貼紙'));

      closeBtn.addEventListener('click', closeModal);
      modal.addEventListener('click', (e) => {
        if (e.target === modal) closeModal();
      });

      saveBtn.addEventListener('click', () => {
        const title = titleInput.value.trim();
        if (!title) {
          showToast('請輸入貼紙名稱');
          return;
        }

        const colorCategory = document.querySelector('input[name="customColor"]:checked').value;
        const theme = COLOR_THEMES[colorCategory] || COLOR_THEMES.work;

        const newSticker = {
          id: 'sticker_' + Date.now(),
          title: title,
          category: colorCategory,
          bg: theme.bg,
          border: theme.border,
          text: theme.text
        };

        const scope = targetScope.value;
        if (scope === 'library') {
          STATE.stickers[colorCategory].push(newSticker);
          renderPaletteCategory(colorCategory);
          setActiveSticker(newSticker);
          showToast(`已新增「${title}」至貼紙庫`);
        } else if (scope === 'week') {
          // Add to current active day (e.g. today / Tuesday index 1)
          addWeekSticker(1, newSticker);
        } else if (scope === 'month') {
          // Add to today's date (Nov 3)
          addMonthSticker('2026-11-03', newSticker);
        }

        closeModal();
      });
    }

    // ---------- Toast Notification Utility ----------
    let toastTimeout = null;
    function showToast(text) {
      const toast = document.getElementById('toastMessage');
      const label = document.getElementById('toastText');
      label.textContent = text;
      toast.classList.remove('opacity-0');

      if (toastTimeout) clearTimeout(toastTimeout);
      toastTimeout = setTimeout(() => {
        toast.classList.add('opacity-0');
      }, 2000);
    }
  </script>
</body>
</html>

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
  <main class="flex-1 max-w-4xl w-full mx-auto p-3 pb-40 relative">

      <!-- Active Sticker Banner (Mobile Quick-Stamp Indicator) -->
      <div id="activeStickerBar" class="hidden mb-3 bg-white/90 border border-amber-300 rounded-2xl p-2.5 shadow-sm flex items-center justify-between animate-fadeIn">
        <div class="flex items-center gap-2 text-xs">
          <span class="text-stone-500 font-medium">蓋章模式:</span>
          <span id="activeStickerPreview" class="px-2.5 py-0.5 rounded-lg text-xs font-bold shadow-sticker"></span>
          <span class="text-[11px] text-stone-400">點擊任意格即可貼上</span>
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

    <!-- ================= Bottom Floating Sticker Palette (貼紙庫) ================= -->
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

      <!-- Sticker Scrollable Dynamic Categories Container -->
      <div id="paletteContent" class="p-3 max-h-52 overflow-y-auto custom-scrollbar space-y-2.5">
        <!-- Rendered dynamically by renderAllCategories() -->
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

  <!-- ================= MODAL 2: CUSTOM STICKER & CATEGORY CREATION (新增貼紙與類別) ================= -->
  <div id="newStickerModal" class="fixed inset-0 z-50 bg-black/40 backdrop-blur-sm flex items-end sm:items-center justify-center p-0 sm:p-4 opacity-0 pointer-events-none transition-opacity duration-200">
    <div class="bg-white w-full sm:max-w-md rounded-t-3xl sm:rounded-3xl p-5 shadow-2xl transform translate-y-6 sm:translate-y-0 transition-transform duration-200 max-h-[90vh] overflow-y-auto">
      <div class="flex items-center justify-between border-b border-stone-100 pb-3 mb-4">
        <h3 id="newStickerModalTitle" class="text-base font-bold text-stone-800">新增貼紙</h3>
        <button id="closeNewStickerModalBtn" class="p-1 rounded-lg text-stone-400 hover:text-stone-600 hover:bg-stone-100">
          <i data-lucide="x" class="w-5 h-5"></i>
        </button>
      </div>

      <div class="space-y-4">
        <input type="hidden" id="targetStickerScope" value="library">

        <!-- Sticker Name -->
        <div>
          <label class="block text-xs font-bold text-stone-600 mb-1">貼紙名稱</label>
          <input id="customStickerTitle" type="text" placeholder="例如：改作業、游泳、慢跑" maxlength="12" class="w-full text-xs px-3 py-2 border border-stone-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-amber-500">
        </div>

        <!-- Category Selection & Creation -->
        <div>
          <div class="flex items-center justify-between mb-1">
            <label class="text-xs font-bold text-stone-600">選擇或新增類別</label>
            <button type="button" id="toggleNewCatInputBtn" class="text-[11px] text-amber-600 hover:text-amber-700 font-bold flex items-center gap-0.5">
              <i data-lucide="folder-plus" class="w-3.5 h-3.5"></i>
              <span>建立新類別</span>
            </button>
          </div>

          <!-- Existing Category Select -->
          <select id="categorySelectDropdown" class="w-full text-xs px-3 py-2 border border-stone-300 rounded-xl bg-white focus:outline-none focus:ring-2 focus:ring-amber-500">
            <!-- Dynamically populated -->
          </select>

          <!-- Input for brand new category (initially hidden) -->
          <div id="newCategoryInputWrapper" class="hidden mt-2 p-2.5 bg-stone-50 rounded-xl border border-stone-200 space-y-1.5">
            <span class="text-[11px] font-bold text-stone-600">自訂新類別名稱：</span>
            <div class="flex gap-2">
              <input id="brandNewCategoryName" type="text" placeholder="例如：運動、閱讀、學習" maxlength="8" class="text-xs px-2.5 py-1.5 border border-stone-300 rounded-lg flex-1 focus:outline-none focus:ring-2 focus:ring-amber-500">
              <button type="button" id="cancelNewCatBtn" class="text-xs px-2 py-1 text-stone-400 hover:text-stone-600 font-bold">取消</button>
            </div>
          </div>
        </div>

        <!-- Color Selection: Preset Palettes & Custom Color Picker -->
        <div>
          <label class="block text-xs font-bold text-stone-600 mb-1.5">選擇顏色</label>
          <!-- Preset Color Palette Swatches -->
          <div class="grid grid-cols-6 gap-2 mb-2" id="colorPresetsContainer">
            <!-- Rendered by JS -->
          </div>

          <!-- Custom Color Picker -->
          <div class="flex items-center justify-between p-2 rounded-xl border border-stone-200 bg-stone-50">
            <div class="flex items-center gap-2">
              <input type="color" id="customColorInput" value="#EAF3EC" class="w-7 h-7 rounded-lg border-0 cursor-pointer bg-transparent">
              <span class="text-xs text-stone-600 font-medium">或自行挑選顏色</span>
            </div>
            <div id="colorPreviewChip" class="px-3 py-1 rounded-lg text-xs font-bold border shadow-sm">
              預覽樣式
            </div>
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
    // Preset soft pastel color palettes (background, border, text color)
    const PRESET_COLORS = [
      { name: '1', bg: '#EAF3EC', border: '#78A987', text: '#22543D' },
      { name: '2', bg: '#FFF3E6', border: '#F6AD55', text: '#9C4221' },
      { name: '3', bg: '#EBF4FF', border: '#63B3ED', text: '#2B6CB0' },
      { name: '4', bg: '#FFF0F2', border: '#F687B3', text: '#97266D' },
      { name: '5', bg: '#F5EEF8', border: '#B794F4', text: '#553C9A' },
      { name: '6', bg: '#FEFCBF', border: '#D69E2E', text: '#744210' },
    ];

    // Current selected color object for modal
    let selectedColorConfig = { ...PRESET_COLORS[0] };

    // ---------- State Management ----------
    const STATE = {
      currentView: 'day',
      isReadOnly: false,
      activeSticker: null,
      draggedStickerData: null,
      // Categories dictionary: id -> name (clean names: no color suffix)
      categories: [
        { id: 'work', name: '工作' },
        { id: 'kids', name: '小孩' },
        { id: 'commute', name: '通勤' },
        { id: 'home', name: '家' },
      ],
      // Stickers map grouped by category id
      stickersByCategory: {
        'work': [
          { id: 'w1', title: '改作業', categoryId: 'work', bg: '#EAF3EC', border: '#78A987', text: '#22543D' },
          { id: 'w2', title: '手繪', categoryId: 'work', bg: '#EAF3EC', border: '#78A987', text: '#22543D' },
          { id: 'w3', title: '電繪', categoryId: 'work', bg: '#EAF3EC', border: '#78A987', text: '#22543D' },
        ],
        'kids': [
          { id: 'k1', title: '鋼琴', categoryId: 'kids', bg: '#FFF3E6', border: '#F6AD55', text: '#9C4221' },
          { id: 'k2', title: '足球', categoryId: 'kids', bg: '#FFF3E6', border: '#F6AD55', text: '#9C4221' },
          { id: 'k3', title: '網球', categoryId: 'kids', bg: '#FFF3E6', border: '#F6AD55', text: '#9C4221' },
          { id: 'k4', title: '滑板', categoryId: 'kids', bg: '#FFF3E6', border: '#F6AD55', text: '#9C4221' },
        ],
        'commute': [
          { id: 'c1', title: '車子', categoryId: 'commute', bg: '#EBF4FF', border: '#63B3ED', text: '#2B6CB0' },
          { id: 'c2', title: '摩托車', categoryId: 'commute', bg: '#EBF4FF', border: '#63B3ED', text: '#2B6CB0' },
        ],
        'home': [
          { id: 'h1', title: '煮飯', categoryId: 'home', bg: '#FFF0F2', border: '#F687B3', text: '#97266D' },
          { id: 'h2', title: '家務', categoryId: 'home', bg: '#FFF0F2', border: '#F687B3', text: '#97266D' },
        ]
      },
      // Day schedule map: "06:00" -> sticker
      daySchedule: {},
      // Week plan slots: 0-6 -> array of stickers
      weekSchedule: {
        '0': [{ id: 'w1_seed', title: '改作業', bg: '#EAF3EC', border: '#78A987', text: '#22543D' }],
        '2': [{ id: 'w2_seed', title: '足球', bg: '#FFF3E6', border: '#F6AD55', text: '#9C4221' }],
        '4': [{ id: 'w3_seed', title: '電繪', bg: '#EAF3EC', border: '#78A987', text: '#22543D' }],
      },
      // Month schedule: date string -> array of stickers
      monthSchedule: {
        '2026-11-03': [{ id: 'm1_seed', title: '鋼琴', bg: '#FFF3E6', border: '#F6AD55', text: '#9C4221' }],
        '2026-11-12': [{ id: 'm2_seed', title: '網球', bg: '#FFF3E6', border: '#F6AD55', text: '#9C4221' }],
        '2026-11-20': [{ id: 'm3_seed', title: '煮飯', bg: '#FFF0F2', border: '#F687B3', text: '#97266D' }]
      }
    };

    // Helper: auto compute border & text color from background hex
    function deriveStickerTheme(hexColor) {
      return {
        bg: hexColor,
        border: adjustBrightness(hexColor, -25),
        text: adjustBrightness(hexColor, -60)
      };
    }

    function adjustBrightness(hex, percent) {
      let num = parseInt(hex.replace('#', ''), 16);
      let r = (num >> 16) + Math.round(255 * (percent / 100));
      let g = ((num >> 8) & 0x00FF) + Math.round(255 * (percent / 100));
      let b = (num & 0x0000FF) + Math.round(255 * (percent / 100));
      r = Math.min(255, Math.max(0, r));
      g = Math.min(255, Math.max(0, g));
      b = Math.min(255, Math.max(0, b));
      return '#' + ((1 << 24) + (r << 16) + (g << 8) + b).toString(16).slice(1);
    }

    // Initialize UI on Load
    window.addEventListener('DOMContentLoaded', () => {
      lucide.createIcons();
      buildDayViewGrid();
      buildWeekViewGrid();
      buildMonthViewGrid();
      renderAllCategories();
      setupEventListeners();
      seedSampleSchedule();
    });

    // ---------- Seed Initial Day Stickers ----------
    function seedSampleSchedule() {
      STATE.daySchedule['07:30'] = { ...STATE.stickersByCategory.commute[0] };
      STATE.daySchedule['08:00'] = { ...STATE.stickersByCategory.work[0] };
      STATE.daySchedule['10:15'] = { ...STATE.stickersByCategory.work[2] };
      STATE.daySchedule['17:30'] = { ...STATE.stickersByCategory.kids[1] };
      STATE.daySchedule['19:00'] = { ...STATE.stickersByCategory.home[0] };
      renderDayView();
    }

    // ---------- Build Day View (Numbers vertically aligned with upper horizontal line) ----------
    function buildDayViewGrid() {
      const grid = document.getElementById('dayTimeGrid');
      grid.innerHTML = '';
      const quarters = ['00', '15', '30', '45'];

      for (let h = 6; h <= 24; h++) {
        const hourStr = h < 10 ? `0${h}` : `${h}`;
        const row = document.createElement('div');
        row.className = 'grid grid-cols-[54px_1fr_1fr_1fr_1fr] min-h-[50px] items-stretch text-xs hover:bg-stone-50/70 transition-colors border-b border-stone-200/70 last:border-b-0 relative';

        // Hour Label column: Single clean number aligned to the top edge
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

      const totalDays = 30;
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

    // ---------- Create Sticker Element (Pure text, custom color support) ----------
    function createStickerElement(sticker, onDelete, variant = 'normal') {
      const chip = document.createElement('div');
      const isCompact = variant === 'compact';

      chip.className = `sticker-chip sticker-placed inline-flex items-center gap-1 rounded-xl shadow-sticker border font-bold cursor-grab active:cursor-grabbing transition-all select-none ${
        isCompact ? 'px-1.5 py-0.5 text-[10px] w-full justify-between' : 'px-2 py-1 text-xs justify-between w-full'
      }`;

      // Apply dynamic colors via style to support custom hex colors
      chip.style.backgroundColor = sticker.bg;
      chip.style.borderColor = sticker.border;
      chip.style.color = sticker.text;

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

    // ---------- Dynamic Categories & Palette Rendering ----------
    function renderAllCategories() {
      const paletteContent = document.getElementById('paletteContent');
      if (!paletteContent) return;
      paletteContent.innerHTML = '';

      STATE.categories.forEach(cat => {
        const row = document.createElement('div');
        row.className = 'flex items-center gap-2 overflow-x-auto pb-1';

        // Clean Category Label (NO color words)
        const label = document.createElement('span');
        label.className = 'text-[11px] font-bold text-stone-500 shrink-0 w-10 truncate text-left';
        label.textContent = cat.name;
        label.title = cat.name;
        row.appendChild(label);

        // Stickers Row
        const stickersContainer = document.createElement('div');
        stickersContainer.className = 'flex items-center gap-2 flex-wrap';

        const list = STATE.stickersByCategory[cat.id] || [];
        if (list.length === 0) {
          const empty = document.createElement('span');
          empty.className = 'text-[10px] text-stone-300 italic';
          empty.textContent = '無貼紙';
          stickersContainer.appendChild(empty);
        } else {
          list.forEach((item, index) => {
            const chip = document.createElement('div');
            chip.className = 'sticker-chip inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl shadow-sticker border text-xs font-bold cursor-pointer select-none active:scale-95 transition-all';
            chip.style.backgroundColor = item.bg;
            chip.style.borderColor = item.border;
            chip.style.color = item.text;
            chip.draggable = !STATE.isReadOnly;

            // Pure text title (No icon)
            const textSpan = document.createElement('span');
            textSpan.textContent = item.title;
            chip.appendChild(textSpan);

            // Delete button
            if (!STATE.isReadOnly) {
              const delBtn = document.createElement('button');
              delBtn.type = 'button';
              delBtn.className = 'text-stone-400 hover:text-rose-600 ml-1 p-0.5 rounded-full hover:bg-black/5 flex items-center justify-center shrink-0 text-xs font-bold leading-none';
              delBtn.innerHTML = '✕';
              delBtn.title = '刪除此貼紙';
              delBtn.addEventListener('click', (e) => {
                e.stopPropagation();
                STATE.stickersByCategory[cat.id].splice(index, 1);
                if (STATE.activeSticker && STATE.activeSticker.id === item.id) {
                  clearActiveSticker();
                }
                renderAllCategories();
                showToast(`已刪除「${item.title}」`);
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

            stickersContainer.appendChild(chip);
          });
        }

        row.appendChild(stickersContainer);
        paletteContent.appendChild(row);
      });

      updateCategoryDropdown();
    }

    function updateCategoryDropdown() {
      const select = document.getElementById('categorySelectDropdown');
      if (!select) return;
      select.innerHTML = '';
      STATE.categories.forEach(cat => {
        const opt = document.createElement('option');
        opt.value = cat.id;
        opt.textContent = cat.name;
        select.appendChild(opt);
      });
    }

    function setActiveSticker(item) {
      STATE.activeSticker = item;
      const bar = document.getElementById('activeStickerBar');
      const preview = document.getElementById('activeStickerPreview');

      bar.classList.remove('hidden');
      preview.style.backgroundColor = item.bg;
      preview.style.borderColor = item.border;
      preview.style.color = item.text;
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

      // 4. Drawer Toggle
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

      // 6. Custom Sticker & Dynamic Category Modal Handlers
      setupNewStickerModalHandlers();
    }

    function switchView(viewName) {
      STATE.currentView = viewName;
      document.querySelectorAll('.view-tab-btn').forEach(btn => {
        const isActive = btn.dataset.view === viewName;
        if (isActive) {
          btn.className = 'view-tab-btn py-1.5 rounded-xl transition flex items-center justify-center gap-1 bg-white text-stone-900 shadow-sm font-bold';
        } else {
          btn.className = 'view-tab-btn py-1.5 rounded-xl transition flex items-center justify-center gap-1 hover:text-stone-900 font-bold';
        }
      });

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
      renderAllCategories();
      renderWeekStickers();
      renderMonthStickers();
    }

    // ---------- Modal: Create Sticker, New Categories, & Color Pickers ----------
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

      // Category toggle elements
      const toggleNewCatBtn = document.getElementById('toggleNewCatInputBtn');
      const newCatWrapper = document.getElementById('newCategoryInputWrapper');
      const newCatInput = document.getElementById('brandNewCategoryName');
      const cancelNewCatBtn = document.getElementById('cancelNewCatBtn');
      const categoryDropdown = document.getElementById('categorySelectDropdown');

      // Color elements
      const colorPresetsContainer = document.getElementById('colorPresetsContainer');
      const customColorInput = document.getElementById('customColorInput');
      const colorPreviewChip = document.getElementById('colorPreviewChip');

      // Render preset colors
      colorPresetsContainer.innerHTML = '';
      PRESET_COLORS.forEach((color, idx) => {
        const swatch = document.createElement('button');
        swatch.type = 'button';
        swatch.className = `w-full h-8 rounded-xl border-2 transition-all flex items-center justify-center ${idx === 0 ? 'border-stone-800 scale-105 shadow-sm' : 'border-stone-200'}`;
        swatch.style.backgroundColor = color.bg;
        swatch.dataset.index = idx;

        swatch.addEventListener('click', () => {
          document.querySelectorAll('#colorPresetsContainer button').forEach(b => {
            b.className = 'w-full h-8 rounded-xl border-2 border-stone-200 transition-all flex items-center justify-center';
          });
          swatch.className = 'w-full h-8 rounded-xl border-2 border-stone-800 scale-105 shadow-sm transition-all flex items-center justify-center';
          selectedColorConfig = { ...color };
          updateColorPreview();
        });

        colorPresetsContainer.appendChild(swatch);
      });

      // Custom native color input
      customColorInput.addEventListener('input', (e) => {
        document.querySelectorAll('#colorPresetsContainer button').forEach(b => {
          b.className = 'w-full h-8 rounded-xl border-2 border-stone-200 transition-all flex items-center justify-center';
        });
        const hex = e.target.value;
        selectedColorConfig = deriveStickerTheme(hex);
        updateColorPreview();
      });

      function updateColorPreview() {
        colorPreviewChip.style.backgroundColor = selectedColorConfig.bg;
        colorPreviewChip.style.borderColor = selectedColorConfig.border;
        colorPreviewChip.style.color = selectedColorConfig.text;
        colorPreviewChip.textContent = titleInput.value.trim() || '預覽樣式';
      }

      titleInput.addEventListener('input', updateColorPreview);

      // Toggle new category creation box
      toggleNewCatBtn.addEventListener('click', () => {
        newCatWrapper.classList.remove('hidden');
        newCatInput.focus();
      });

      cancelNewCatBtn.addEventListener('click', () => {
        newCatWrapper.classList.add('hidden');
        newCatInput.value = '';
      });

      const openModalFor = (scope, headerText) => {
        targetScope.value = scope;
        modalTitle.textContent = headerText;
        titleInput.value = '';
        newCatInput.value = '';
        newCatWrapper.classList.add('hidden');
        updateCategoryDropdown();
        selectedColorConfig = { ...PRESET_COLORS[0] };
        updateColorPreview();
        modal.classList.remove('opacity-0', 'pointer-events-none');
        titleInput.focus();
      };

      const closeModal = () => {
        modal.classList.add('opacity-0', 'pointer-events-none');
      };

      openLibraryBtn.addEventListener('click', () => openModalFor('library', '新增貼紙至貼紙庫'));
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

        // Determine Category (existing or brand new)
        let finalCatId = categoryDropdown.value;
        const brandNewCat = newCatInput.value.trim();

        if (brandNewCat) {
          const newId = 'cat_' + Date.now();
          STATE.categories.push({ id: newId, name: brandNewCat });
          STATE.stickersByCategory[newId] = [];
          finalCatId = newId;
        }

        const newSticker = {
          id: 'sticker_' + Date.now(),
          title: title,
          categoryId: finalCatId,
          bg: selectedColorConfig.bg,
          border: selectedColorConfig.border,
          text: selectedColorConfig.text
        };

        const scope = targetScope.value;
        if (scope === 'library') {
          if (!STATE.stickersByCategory[finalCatId]) {
            STATE.stickersByCategory[finalCatId] = [];
          }
          STATE.stickersByCategory[finalCatId].push(newSticker);
          renderAllCategories();
          setActiveSticker(newSticker);
          showToast(`已新增「${title}」至貼紙庫`);
        } else if (scope === 'week') {
          addWeekSticker(1, newSticker);
        } else if (scope === 'month') {
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

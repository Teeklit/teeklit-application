import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'teekle_model.dart';

void showTeekleRepeatSheet(context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: const Color(0xFF2C2C2E),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => const RepeatBottomSheet(),
  );
}

class RepeatBottomSheet extends StatefulWidget {
  final

  @override
  State<RepeatBottomSheet> createState() => _RepeatBottomSheetState();
}

class _RepeatBottomSheetState extends State<RepeatBottomSheet> {
  bool repeat = false;
  String repeatCycle = 'weekly';
  List<String> selectedRepeatDays = [];

  bool showRepeatPicker = false;
  int selectedPickerIndex = 0;

  final List<String> days = ['월', '화', '수', '목', '금', '토', '일'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 20, MediaQuery.of(context).viewInsets.bottom + 56,),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 바텀시트 헤더
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '반복',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // 반복 없음 버튼
          // todo: 선택 시 weekly/monthly, 요일선택, 반복 주기 비활성화.
          GestureDetector(
            onTap: () => setState(() => repeat = !repeat),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              decoration: BoxDecoration(
                color: repeat ? Color(0xffCCDBBB) : Color(0xFF6C6C6C),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                '반복 없음',
                style: TextStyle(
                  color: repeat ? const Color(0xff333333) : Color(0xFFffffff),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // 월간 / 주간 토글
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => repeatCycle = 'weekly'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: repeatCycle == 'weekly'
                          ? const Color(0xFFD0E0C0)
                          : const Color(0xFF6C6C6C),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '주간',
                        style: TextStyle(
                          color: repeatCycle == 'weekly'
                              ? const Color(0xff333333)
                              : const Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => repeatCycle = 'monthly'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: repeatCycle == 'monthly'
                          ? const Color(0xFFD0E0C0)
                          : const Color(0xFF6C6C6C),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '월간',
                        style: TextStyle(
                          color: repeatCycle == 'monthly'
                              ? const Color(0xff333333)
                              : const Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // 반복 주기
          // todo: 월간 / 주간 토글 선택에 따라서 월간/주간 반복주기 picker가 바텀시트 내부에서 나와야함.
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '반복 주기',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    showRepeatPicker = !showRepeatPicker;
                  });
                },
                child: Row(
                  children: [
                    Text(
                      repeatCycle == 'weekly'
                          ? '${selectedPickerIndex + 1}주마다'
                          : '${selectedPickerIndex + 1}달마다',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.white,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // 요일 선택
          const Text(
            '요일 선택',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: days.map((day) {
              final isSelected = selectedRepeatDays.contains(day);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      selectedRepeatDays.remove(day);
                    } else {
                      selectedRepeatDays.add(day);
                    }
                  });
                },
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: isSelected
                      ? const Color(0xFFD0E0C0)
                      : const Color(0xFF3A3A3C),
                  child: Text(
                    day,
                    style: TextStyle(
                      color: isSelected ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          // const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class WeeklyRepeatCyclePicker extends StatefulWidget {
  const WeeklyRepeatCyclePicker({super.key});

  @override
  State<WeeklyRepeatCyclePicker> createState() => _WeeklyRepeatCyclePicker();
}

class _WeeklyRepeatCyclePicker extends State<WeeklyRepeatCyclePicker> {
  static const double _kItemExtent = 32.0;
  int _selectedCycle = 0;
  final List<String> weeklyCycle = ['1주마다', '2주마다', '3주마다'];

  // This shows a CupertinoModalPopup with a reasonable fixed height which hosts CupertinoPicker.
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(top: false, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CupertinoButton(
          padding: EdgeInsets.zero,
          // Display a CupertinoPicker with list of fruits.
          onPressed: () => _showDialog(
            CupertinoPicker(
              magnification: 1.22,
              squeeze: 1.2,
              useMagnifier: true,
              itemExtent: _kItemExtent,
              // This sets the initial item.
              scrollController: FixedExtentScrollController(
                initialItem: _selectedCycle,
              ),
              // This is called when selected item is changed.
              onSelectedItemChanged: (int selectedItem) {
                setState(() {
                  _selectedCycle = selectedItem;
                });
              },
              children: List<Widget>.generate(weeklyCycle.length, (int index) {
                return Center(child: Text(weeklyCycle[index]));
              }),
            ),
          ),
          // This displays the selected fruit name.
          child: Text(
            weeklyCycle[_selectedCycle],
            style: const TextStyle(fontSize: 22.0),
          ),
        ),
      ],
    );
  }
}

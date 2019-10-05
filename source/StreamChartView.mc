using Toybox.WatchUi;
using StreamChart;

class StreamChartView extends WatchUi.View {
  
    var chart;

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        chart = new StreamChart.Chart(dc, null);
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        chart.drawXAxis(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

}

(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){

},{}],2:[function(require,module,exports){
var Chart, helpers, supportedTypes, colourProfile, defaultOptions;

//setup
Chart = require('Chart');
Chart = typeof(Chart) === 'function' ? Chart : window.Chart;
helpers = Chart.helpers;
colourProfile = 'borderColor';
baseColor = [];
supportedTypes = {
  'line': 'borderColor'
};

Chart.Bands = Chart.Bands || {};

defaultOptions = Chart.Bands.defaults = {
  bands: {
    yValue: false,
    bandLine: {
        stroke: 0.01,
        colour: 'rgba(0, 0, 0, 1.000)',
        type: 'solid',
        label: '',
        fontSize: '12',
        fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif',
        fontStyle: 'normal'
    },
    belowThresholdColour: [
        'rgba(0, 255, 0, 1.000)'
    ]
  }
};

function pluginBandOptionsHaveBeenSet (bandOptions) {
  return (typeof bandOptions.belowThresholdColour === 'object' && bandOptions.belowThresholdColour.length > 0 && typeof bandOptions.yValue === 'number');
}

function calculateGradientFill (ctx, scale, height, baseColor, gradientColor, value) {
  var yPos = scale.getPixelForValue(value),
      grd = ctx.createLinearGradient(0, height, 0, 0);
      gradientStop = 1 - (yPos / height);
  try {
      grd.addColorStop(gradientStop, gradientColor);
      grd.addColorStop(gradientStop, baseColor);
      return grd;
  } catch (e) {
      console.warn('ConfigError: Chart.Bands.js had a problem applying one or more colors please check that you have selected valid color strings');
      return baseColor;
  }
}

function isPluginSupported (type) {
  if (!!supportedTypes[type]) {
      colourProfile = supportedTypes[type];
      return true;
  }
  return;
}

var BandsPlugin = Chart.PluginBase.extend({
  beforeInit: function (chartInstance) {
    Chart.Bands.isSupported = isPluginSupported(chartInstance.config.type);
    for (var i = 0; i < chartInstance.chart.config.data.datasets.length; i++) {
        baseColor[i] = chartInstance.chart.config.data.datasets[i][colourProfile];
    }
  },

  afterScaleUpdate: function (chartInstance) {
    var node,
        bandOptions,
        fill;
    if (!Chart.Bands.isSupported) { return; }
    node = chartInstance.chart.ctx.canvas;
    bandOptions = helpers.configMerge(Chart.Bands.defaults.bands, chartInstance.options.bands);
    if (pluginBandOptionsHaveBeenSet(bandOptions)) {
      var ctx = chartInstance.chart.ctx;
      var originalStroke = chartInstance.chart.ctx.stroke;
      ctx.stroke = function () {
          ctx.save();
          ctx.shadowColor = '#857fa2';
          ctx.shadowBlur = 4;
          ctx.shadowOffsetX = 0;
          ctx.shadowOffsetY = 2;
          originalStroke.apply(this, arguments)
          ctx.restore();
      }
      for (var i = 0; i < chartInstance.chart.config.data.datasets.length; i++) {
          fill = calculateGradientFill(
                                  node.getContext("2d"),
                                  chartInstance.scales['y-axis-0'],
                                  chartInstance.chart.height,
                                  baseColor[i],
                                  bandOptions.belowThresholdColour[i],
                                  bandOptions.yValue
                              );
          chartInstance.chart.config.data.datasets[i]['backgroundColor'] = fill;
      }
    } else {
      console.warn('ConfigError: The Chart.Bands.js config seems incorrect');
    }
  }
});

Chart.pluginService.register(new BandsPlugin());
},{"Chart":1}]},{},[2]);

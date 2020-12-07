var SIR_model_data = {
// SIR model data

    model_name: 'SIR model',

    myChart: Object,

    // chart line name
    s_name: 'susceptible',
    i_name: 'infective',
    r_name: 'recovery_remove',

    // hyperparameters
    r : 0.00001,  // get infected ratio
    a : 1/50, // recovered or dead ratio

    // chart line data
    s_data:[[0,100000]],
    i_data:[[0,20]],
    r_data:[[0,0]],

    // interval for start and stop
    simulationInterval: null,

    // number of passed days
    dayCount:0,

    // the people that can be infected by virus
    susceptible:0,

    // the infected people
    infective:0,

    // recovered or dead peopled
    recovery_remove:0
}



var simulator = new Vue({
    el:'#simulator',
    data:SIR_model_data,
    
    mounted :function () {
        // after vue create vm.$el and replance el with it
        this.$nextTick(function () {
            console.log("create the chart")
            this.myChart = echarts.init(document.getElementById('chart'));
            // set initial chart options
            this.setChartOptions();
        })
        // create echart

    },

    methods:{
        setChartOptions() {
            // initialize the echart

            options = {
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'cross',
                        label: {
                            backgroundColor: '#6a7985'
                        }
                    }
                },
                legend: {
                    data: [this.s_name,this.i_name,this.r_name]
                },
                toolbox: {
                    feature: {

                    }
                },
                grid: {
                    left: '3%',
                    right: '4%',
                    bottom: '3%',
                    containLabel: true
                },
                xAxis: [
                    {
                        type: 'value',
                    }
                ],
                yAxis: [
                    {
                        type: 'value'
                    }
                ],
                series:[
                    {
                        name: this.s_name,
                        type: 'line',
                        smooth: true,
                        data: this.s_data
                    },
                    {
                        name: this.i_name,
                        type: 'line',
                        smooth: true,
                        data: this.i_data
                    },
                    {
                        name: this.r_name,
                        type: 'line',
                        smooth: true,
                        data: this.r_data
                    }
                ]
            };

            this.myChart.setOption(options);
        },
        startSimulate: function(event) {
            // start outbreak simulation
            if(this.simulationInterval==null){
                console.log("start simulate")
                let that = this
                this.simulationInterval = setInterval(function () {



                    var oldS = that.s_data[that.dayCount][1]
                    var oldI = that.i_data[that.dayCount][1]
                    var oldR = that.r_data[that.dayCount][1]

                    var newS = parseInt(oldS - that.r*oldI*oldS)
                    var newI = parseInt(oldI + that.r*oldI*oldS - that.a*oldI)
                    var newR = parseInt(that.a*oldI + oldR)

                    that.dayCount++; // update nubmer of day

                    that.s_data.push([that.dayCount,newS])
                    that.i_data.push([that.dayCount,newI])
                    that.r_data.push([that.dayCount,newR])

                    that.myChart.setOption({
                        series:[
                            {
                                name: that.s_name,
                                data: that.s_data
                            },
                            {
                                name: that.i_name,
                                data: that.i_data
                            },
                            {
                                name: that.r_name,
                                data: that.r_data
                            }
                        ]
                    });


                }, 300);
            }


        },
        stopSimulate: function(event) {
            if(this.simulationInterval!=null)
                clearInterval(this.simulationInterval);
            this.simulationInterval = null
        },
        resetSimulate: function (event){
            // step simulate first
            this.stopSimulate()
            // start outbreak simulation
            console.log("reset simulate")
            let that = this

            that.s_data=[[0,100000]]
            that.i_data=[[0,20]]
            that.r_data=[0,0]

            that.dayCount=0

            that.myChart.setOption({
                series:[
                    {
                        name: that.s_name,
                        data: that.s_data
                    },
                    {
                        name: that.i_name,
                        data: that.i_data
                    },
                    {
                        name: that.r_name,
                        data: that.r_data
                    }
                ]
            });

        }
    }
})
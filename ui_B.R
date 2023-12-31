#****************************************************************************************************************************************************1.4. beta

sidebarLayout(

	sidebarPanel(

	h4(tags$b("Step 1. Select the data source")),
	p("Mathematical-based, simulated-data-based, or user data-based"),
	#Select Src
	selectInput(
	    "InputSrc_b", "Select plot",
      c("Mathematical formula based" = "MathDist",
        "Simulation data based" = "SimuDist",
        "Upload data based" = "DataDist")),
	hr(),
	#Select Src end
	h4(tags$b("Step 2. Set parameters")),
	#condiPa 1
	  conditionalPanel(
	    condition = "input.InputSrc_b == 'MathDist'",
	    HTML("<b>1. Set Parameters for Beta(&#945, &#946)</b>"),
	    #HTML("<h4><b>Step 1. Set Parameters for Beta(&#945, &#946)</h4></b>"),
		numericInput("b.shape", HTML("&#945 > 0, Shape parameter"), value = 12, min = 0),
		  numericInput("b.scale", HTML("&#946 > 0, Shape parameter"), value = 12, min = 0),
		  hr(),
		  numericInput("b.mean", HTML("Or. Calculate k and &#952 from Mean and SD (Mean = SD), input mean"), value = 0.5, min = 0),
			numericInput("b.sd", HTML("Input SD"), value = 0.1, min = 0),

verbatimTextOutput("b.rate"),
HTML("<li> Mean = &#945 / (&#945 + &#946)
			<li> Variance = &#945&#946/[(&#945 + &#946)^2(&#945 + &#946+1)]"),
		hr(),
		  numericInput("b.xlim", "Change the range of x-axis, > 0", value = 1, min = 1)
		  #snumericInput("b.ylim", "Range of y-asis, > 0", value = 2.5, min = 0.1, max = 3),
	  ),
	 #condiPa 1 end

	  #condiPa 2
	  conditionalPanel(
	    condition = "input.InputSrc_b == 'SimuDist'",
	    numericInput("b.size", "Sample size of simulated numbers", value = 100, min = 1, step = 1),
	    sliderInput("b.bin", "The number of bins in histogram", min = 0, max = 100, value = 0),
		p("When the number of bins is 0, plot will use the default number of bins")

	  ),
	  #condiPa 2 end

	  #condiPa 3
	  conditionalPanel(
	    condition = "input.InputSrc_b == 'DataDist'",

	    tabsetPanel(
	       tabPanel("Manual Input",p(br()),
		p("Data point can be separated by , ; /Enter /Tab /Space"),
		p(tags$b("Data be copied from CSV (one column) and pasted in the box")),
    	tags$textarea(
        id = "x.b", #p
        rows = 10,
"0.11\n0.57\n0.59\n0.52\n0.13\n0.45\n0.63\n0.68\n0.44\n0.55\n0.48\n0.54\n0.29\n0.41\n0.64\n0.75\n0.33\n0.24\n0.45\n0.18"
),
      	p("Missing value is input as NA")
	     	 ), #tab1 end

tabPanel.upload.num(file ="b.file", header="b.header", col="b.col", sep="b.sep")

	    ),
		sliderInput("bin.b","The number of bins in histogram", min = 0, max = 100, value = 0),
        p("When the number of bins is 0, plot will use the default number of bins")
	  ),
	  #condiPa 3 end
	  hr(),
	  h4(tags$b("Step 3. Change Probability")),
 		numericInput("b.pr", HTML("Area Proportion Left to Red-line = Pr(X < x<sub>0</sub>), x<sub>0</sub> is the position of Red-line"), value = 0.05, min = 0, max = 1, step = 0.05),
	  hr()
	), #sidePa end

mainPanel(
		h4(tags$b("Outputs")),

		conditionalPanel(
		  condition = "input.InputSrc_b == 'MathDist'",
		  h4("Mathematical-based Plot"),
		tags$b("Beta distribution plot"),
        plotOutput("b.plot", click = "plot_click13"),
        verbatimTextOutput("b.info"),
        #HTML("<p><b>The position of Red-line, x<sub>0</sub></b></p>"),
        #p(tags$b("The position of Red-line, x<sub>0</sub>")),
        #tableOutput("b")
   hr(),
#    plotly::plotlyOutput("b.plot.cdf")  
plotOutput("b.plot.cdf") 
		),

		conditionalPanel(
		  condition = "input.InputSrc_b == 'SimuDist'",
		   h4("Simulation-based Plot"),

		tags$b("Histogram from random numbers"),
        plotly::plotlyOutput("b.plot2"),# click = "plot_click14",

        #verbatimTextOutput("b.info2"),
        downloadButton("download4", "Download Random Numbers"),
        p(tags$b("Sample descriptive statistics")),
        tableOutput("b.sum"),
        HTML(
    "
    <b> Explanation </b>
   <ul>
    <li>  Mean = &#945/(&#945+&#946) </li>
    <li>  SD = sqrt(&#945*&#946/(&#945+&#946)^2(&#945+&#946+1)) </li>
   </ul>
    "
    )

		),

		conditionalPanel(
		condition = "input.InputSrc_b == 'DataDist'",

		tags$b("Data preview"),
		DT::DTOutput("ZZ"),
		h4("Distribution of Your Data"),
        tags$b("Density from upload data"),
        plotly::plotlyOutput("makeplot.b2"),
        tags$b("Histogram from upload data"),
        plotly::plotlyOutput("makeplot.b1"),
        tags$b("CDF from upload data"),
        plotly::plotlyOutput("makeplot.b3"),
        p(tags$b("Sample descriptive statistics")),
        tableOutput("b.sum2")



		)

	) #main pa end


	)


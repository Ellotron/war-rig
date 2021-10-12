require("pieces")

player1BaseToWasteToSand =
{
    {
        guid = 'bb1fd3',
        position = { x = 1.2919408082962, y = 1.8911874294281, z = -0.156608805060387 },
        rotation = { x = -0.000546854746062309, y = 0.000633342075161636, z = 180.00032043457 },
        thenPlace =
        {
            guid = 'bb1fd3',
            position = { x = -1.16872978210449, y = 1.89118790626526, z = 8.05396366119385 },
            rotation = { x = -0.000544640410225838, y = 0.000985334161669016, z = 180.00032043457 }
        },
    },
    {
        guid = '2348af',
        position = { x = 0.160534277558327, y = 1.89103806018829, z = -1.2012323141098 },
        rotation = { x = -0.00452942820265889, y = 0.0218223910778761, z = 0.00145441456697881 },
        thenPlace =
          {
            guid = '2348af',
            position = { x = -2.30014491081238, y = 1.89103853702545, z = 7.00934314727783 },
            rotation = { x = -0.00451698200777173, y = 0.0221160799264908, z = 0.00144428771454841 }
          },
      },
}

player2BaseToWatesAndGather = {
  {
    guid = '3bb1a3',
    position = { x = -0.429877638816834, y = 1.89118826389313, z = 0.182901248335838 },
    rotation = { x = -0.000534872582647949, y = 180.001129150391, z = 180.000366210938 },
    thenPlace =
        {
            containerGuid = '5f986f',
            position = { x = -0.410172432661057, y = 1.99107754230499, z = 0.188939526677132 },
            rotation = { x = -0.000761659583076835, y = 180.000717163086, z = -0.00332035194151104 }
        },
  },
  {
    guid = '5a7b17',
    position = { x = 0.696883141994476, y = 1.89104223251343, z = 1.23953485488892 },
    rotation = { x = -0.00456802733242512, y = 179.99186706543, z = 0.00127844186499715 }
  },
}

tutorial1 =
{
    title = 'Squad Movement and Gathering',
    steps =
    {
        {
            stepType = STEP_TYPE_FUNC,
            funcName = 'setup2'
        },
        {
            stepType = STEP_TYPE_TEXT,
            text =
            {
                'Squad Movement and Gathering',
                'In a round each squad has 2 actions',
                'For example:',
                'Player 1 may choose to move to Oil Sands',
                'Click continue to move...'
            },
            delaySeconds = 2.5
        },
        {
            stepType = STEP_TYPE_BREAK
        },
        {
            stepType = STEP_TYPE_MOVE,
            objects = player1BaseToWasteToSand
        },
        {
            stepType = STEP_TYPE_TEXT,
            text =
            {
                'Player 1 moves first to the Barren Wastes',
                'Then to the Oil Sands',
                'Every Basic Location is connected to Barren Wastes',
                'So player 1 has used both actions for this squad',
                'Player 2 decides to gather in the Barren Wastes',
                'Click continue to move and gather...'
            },
            delaySeconds = 3.5
        },
        {
            stepType = STEP_TYPE_BREAK
        },
        {
            stepType = STEP_TYPE_MOVE,
            objects = player2BaseToWatesAndGather
        },
        {
            stepType = STEP_TYPE_TEXT,
            text =
            {
                'Player 2 moves to the Barren Wastes and gathers',
                'Scrap can be used in construction',
                'and to barter for safe passage when attacked',
            },
            delaySeconds = 3.5
        },
    }
}
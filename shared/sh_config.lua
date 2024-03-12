Config = Config or {}

Config.Debug = false -- Enable debug messages

-- Models for dumpsters (https://forge.plebmasters.de/objects)
Config.Dumpsters = {
    "prop_cs_dumpster_01a",
    "p_dumpster_t",
    'prop_dumpster_01a',
    'prop_dumpster_02a',
    'prop_dumpster_02b',
    'prop_dumpster_3a',
    'prop_dumpster_4a',
    'prop_dumpster_4b',
    'prop_cs_bin_01',
    'prop_cs_bin_02',
    'prop_cs_bin_03',
    'prop_bin_01a',
    'prop_bin_08a',
    'prop_bin_08open',
    -- Bags
    'prop_cs_rub_binbag_01',
    'prop_ld_binbag_01',
    'prop_ld_rub_binbag_01',
    'prop_rub_binbag_sd_01',
    'prop_rub_binbag_sd_02',
    'prop_cs_street_binbag_01',
    'p_binbag_01_s',
    'ng_proc_binbag_01a',
    'p_rub_binbag_test',
    'prop_rub_binbag_01',
    'prop_rub_binbag_04',
    'prop_rub_binbag_05',
    'bkr_prop_fakeid_binbag_01',
    'hei_prop_heist_binbag',
    'prop_rub_binbag_01b',
    'prop_rub_binbag_03',
    'prop_rub_binbag_03b',
    'prop_rub_binbag_06',
    'prop_rub_binbag_08',
    'ch_chint10_binbags_smallroom_01',
}

Config.SearchTime = math.random(8000, 12000) -- Time it takes to search a dumpster
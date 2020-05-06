<?php
defined("_VALID_ACCESS") || die('Direct access forbidden');


class rozpiska extends Module {

    public function body(){
        Base_ThemeCommon::install_default_theme($this->get_type());

        if(isset($_REQUEST['__jump_to_RB_table'])){    
            $rs = new RBO_RecordsetAccessor($_REQUEST['__jump_to_RB_table']);
            $rb = $rs->create_rb_module ( $this );
            $this->display_module ( $rb);
        }    

        $data = array();
        //action section
        if(!$this->get_module_variable('dateFilter')) {
            $this->set_module_variable('dateFilter', date("Y-m-d"));
        }
        if($_REQUEST['prev']){
            $date = $this->get_module_variable('dateFilter');
            $date =  date('Y-m-d', strtotime($date. "- 1 day"));
            $this->set_module_variable('dateFilter', $date);
            $this->set_module_variable('display',true);
        }
        if($_REQUEST['next']){
            $date = $this->get_module_variable('dateFilter');
            $date =  date('Y-m-d', strtotime($date. " + 1 day"));
            $this->set_module_variable('dateFilter',$date);
            $this->set_module_variable('display',true);
        }
        //data pre
        $form = &$this->init_module('Libs/QuickForm');
        $form->addElement("datepicker","dateFilter","Dzień transportu", array("autocomplete" => "off"));
        $form->addElement("submit","submit","Filtruj");
        $theme = $this->init_module('Base/Theme');
        $form->toHtml();
        $form->assign_theme('my_form', $theme);


        //form validate section
        if($form->validate()){
            $d = $form->exportValues();  
            if($d['dateFilter']){
                $data['dateFilter'] = $d['dateFilter'];
                $this->set_module_variable('dateFilter',$d['dateFilter']);
            }
            $this->set_module_variable('display',true);
        }

        //assign all data to tpl
        $data['dateFilter'] = $this->get_module_variable('dateFilter');
        $theme->assign("prev", "<a ".$this->create_href(array("prev"=>"1"))."> < </a>");
        $theme->assign("next", "<a ".$this->create_href(array("next"=>"1"))."> > </a>");
        $theme->assign('data' , $data);
        if( $this->get_module_variable('display')){
            $tableTransport = "custom_agrohandel_transporty";
            $tableZakupy = "custom_agrohandel_purchase_plans";
            $rboTransporty = new RBO_RecordsetAccessor($tableTransport);
            $rboZakupy = new RBO_RecordsetAccessor($tableZakupy);
            $rboCompany = new RBO_RecordsetAccessor("company");
            $rboContacts = new RBO_RecordsetAccessor("contact");
            $rboVehicles = new RBO_RecordsetAccessor("custom_agrohandel_vehicle");
            $transports = $rboTransporty->get_records(array("date" => $data['dateFilter'], 'type' => array('tucznik',)),array(),array("number" => "ASC"));
            $transportsList = array();
            foreach($transports as $transport){
                $transportsSelect[] = array('id' => $transport['id'], 'name' => $transport['number']);
                $transport['number'] = $transport->record_link($transport['number'],$nolink = false,$action = 'view');
                $driver = $rboContacts->get_record($transport['driver_1']);
                $company = $rboCompany->get_record($transport['company']);
                $vehicle = $rboVehicles->get_record($transport['vehicle']);
                $transport['company'] = $company['company_name'];
                $transport['day'] = __(date("l", strtotime($transport['date'])));
                $transport['driver_1'] = $driver['first_name']." ".$driver['last_name']; 
                $transport['vehicle'] = $vehicle['name'];
                $zakupy = $transport['zakupy'];
                $zakupy = $rboZakupy->get_records(array('id' => $zakupy),array(),array("numer_pozycji_transportu" => "ASC"));
                $transport['weight'] = $transport['wagarozprzed'] - $transport['wagarozpo'];
                $transport['zakupy'] = array();
                $transportsList[$transport['id']] = $transport;
                foreach($zakupy as $zakup){
                    $zakup['noteTransport'] = "";
                    $zakup['noteHandlowiec'] = "";
                    $zakup['noteDriver'] = "";
                    if($transport['noterozl']){
                        $note .= $transport['noterozl'];
                    }
                    if($zakup['noteh']){
                        $zakup['noteHandlowiec'] = $zakup['noteh'];
                    }
                    if($zakup['note']){
                        $zakup['noteTransport'] = $zakup['note'];
                    }
                    if($zakup['notek']){
                        $zakup['noteDriver'] = $zakup['notek'];
                    }
                    if($zakup['additional_fixing']){
                        $zakup['noteTransport'] = $zakup['additional_fixing'];
                    }
                    $zakup['note'] = $note;
                    
                    $farmer = $rboCompany->get_record($zakup['company']);
                    $opiekun = $rboContacts->get_record($farmer['account_manager']);
                    $zakup['opiekun'] = $opiekun['first_name']." ".$opiekun['last_name'];
                    $zakup['address'] = $farmer['address_1']." ".$farmer['postal_code']." ".$farmer['city'];
                    $zakup['company'] = $farmer['company_name'];
                    $zakup['grupa'] = $farmer->get_val("parent_company",false);
                    $zakup['client']  =  $farmer->get_val("company_name",false);
                    $zakup['kontakt'] =  $farmer ? $farmer['phone']  : $farmer['phonenext'];
                    $full = $zakup['wagazalak'];
                    $empty = $zakup['wagazala'];
                    $weight = 0;
                    $avgWeight = 0;          
                    if($empty == 0 || strlen($empty) == 0 ){
                        $weight = $full;
                    }else{
                        $weight = $full - $empty;
                    }
                    if(!$weight){
                        $weight = 0;
                    }
                    if($zakup['method_of_settlement'] == 'live_weight'){
                        $koszt = $weight - ($zakup['deduction'] * $weight) / 100;
                        $koszt = $koszt * $zakup['price'];
                        $koszt = round($koszt,2);
                        $koszt = str_replace(".",",",$koszt);
                        $koszt = number_format($koszt, 2,',',' ');
                        $zakup['kosztMiesa'] = "Waga żywa: ".$koszt." zł";

                    }else{
                        $zakup['kosztMiesa'] = 'WBC:';
                        /*$weight = WBC;
                        $koszt = $weight - ($zakup['deduction'] * $weight) / 100;
                        $koszt = $koszt * $zakup['price'];
                        $koszt = round($koszt,2);
                        $koszt = str_replace(".",",",$koszt);
                        $zakup['koszt'] = $koszt;
                        $zakup['koszt'] = "Waga żywa: ".$koszt." zł";*/
                    }
                    $kosztTransportu = 0;
                    $kosztTransportu += $zakup['sztukzal'] * 0.9;      
                    $weightOfAll += $weight;
                    $avgWeight = $weight / $zakup['sztukzal'];
                    $avgWeight = round($avgWeight,2);
                    $zakup['weight'] = $weight;
                    $zakup['avgWeight'] = str_replace(".",",",$avgWeight);
                    $zakup['price'] = $zakup->get_val("price",true);
                }
                $transportsList[$transport['id']]['zakupy'] = $zakupy;
            }
            $theme->assign("transports",$transportsList);
            $theme->assign("transportsSelect", $transportsSelect);
        }
        $theme->display();
        $val = $this->get_module_variable("dateFilter");
        Epesi::js("
                    jq('#dateFilter').val('$val');
                ");
        Epesi::js('
        jq("#changeTransport").on("change", function(){
            var id = jq(this).val();
            id = "#"+id;
            jq(".transport").removeClass("display");
            jq(".transport").addClass("hidden");
            jq(id).addClass("display");
            jq(id).removeClass("hidden");
        });
        ');
    }

    public function settings(){}
}
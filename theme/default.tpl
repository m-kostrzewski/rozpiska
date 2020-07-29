<div class="bootstrap-iso" style="font-size: 14px;">
    <div class="container-fluid" style="padding-left: 6px; padding-right: 6px;">
        <div class='row'>
            <div class='col-6'>
                <div class='form-group'>
                    <select class='form-control' id='changeTransport' style='height:unset;width:200px;'>
                        {foreach from=$transportsSelect item=select}
                            <option value='{$select.id}'> {$select.name} </option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class='col-6'>
                <div class='form-group'>
                    {$my_form_open}
                    {foreach from=$my_form_data item=f}
                        {if is_array($f) && isset($f.type) && isset($f.html) && isset($f.label) && $f.type!='hidden' && $f.type!='button' && $f.type!='submit'}
                             {$f.html}
                        {/if}
                    {/foreach}
                     {$my_form_data.submit.html}
                    {$my_form_close}
                </div>
            </div>
        </div>
        {foreach from=$transports item=transport}
          {if ($transport === reset($transports))}
                <div class='transport display'  id='{$transport.id}'> 
            {else}
               <div class='transport hidden'  id='{$transport.id}'>
            {/if}
            <div class='row'>
                <div class='col-6'>
                    <table class='table table-bordered'></table>
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title text-left"> Dane transportu </h5>
                            <ul class="list-group text-left">
                                <ol class="list-group-item">
                                    <li class='list-inline-item text-left'> Nr transportu</li>
                                    <li class='list-inline-item float-right'> {$transport.number} </li>
                                </ol>
                                <ol class="list-group-item">
                                    <li class='list-inline-item text-left'>  Kierowca </li>
                                    <li class='list-inline-item float-right'> {$transport.driver_1} </li>
                                </ol>
                                <ol class="list-group-item">
                                    <li class='list-inline-item text-left'> Samochód </li>
                                    <li class='list-inline-item float-right'> {$transport.vehicle}  </li>
                                </ol>
                                <ol class="list-group-item">
                                    <li class='list-inline-item text-left'> Kilometry rzeczywiste </li>
                                    <li class='list-inline-item float-right'>   </li>
                                </ol>
                                <ol class="list-group-item">
                                    <li class='list-inline-item text-left'> Kilometry przejechane </li>
                                    <li class='list-inline-item float-right'> {$transport.kmprzej}  </li>
                                </ol>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class='col-6'>
                    <table class='table table-bordered'></table>

                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title text-left"> Dane rozładunku </h5>
                            <ul class="list-group text-left">
                                <ol class="list-group-item">
                                    <li class='list-inline-item text-left'> Rozładowane </li>
                                    <li class='list-inline-item float-right'> {$transport.iloscrozl} </li>
                                </ol>
                                <ol class="list-group-item">
                                    <li class='list-inline-item text-left'>  Warunki </li>
                                    <li class='list-inline-item float-right'> {$transport.iloscwaru} </li>
                                </ol>
                                <ol class="list-group-item">
                                    <li class='list-inline-item text-left'> Padłe </li>
                                    <li class='list-inline-item float-right'> {$transport.iloscpadle} </li>
                                </ol>
                                <ol class="list-group-item">
                                    <li class='list-inline-item text-left'> Waga </li>
                                    <li class='list-inline-item float-right'> {$transport.weight}  </li>
                                </ol>
                                <ol class="list-group-item">
                                    <li class='list-inline-item text-left'> Ubytek  </li>
                                    <li class='list-inline-item float-right'> 0 </li>
                                </ol>
                            </ul>
                        </div>
                    </div>
                </div>

            </div>
            {foreach from=$transport.zakupy item=zakup}
            <div class="row">

                <div class='col-3'>
                    <table class='table table-bordered'></table>
                    <div class="card" style='height:100%;'>
                        <div class="card-body">
                            <h5 class="card-title text-left"> Dane Załadunku </h5>
                            <ul class="list-group text-left">
                                <ol class="list-group-item">
                                    <li class='list-inline-item text-left'> Nr ubojowy</li>
                                    <li class='list-inline-item float-right'> {$zakup.numer_ubojowy} </li>
                                </ol>
                                <ol class="list-group-item">
                                    <li class='list-inline-item'> Sztuki planowane </li>
                                    <li class='list-inline-item float-right'> {$zakup.amount} </li>
                                </ol>
                                <ol class="list-group-item">
                                    <li class='list-inline-item text-left'> Sztuki załadowane </li>
                                    <li class='list-inline-item float-right'> {$zakup.sztukzal} </li>
                                </ol>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class='col-3'>
                    <table class='table table-bordered'></table>
                    <div class="card" style='height:100%;'>
                        <div class="card-body">
                            <h5 class="card-title text-left"> Wagi z załadunku </h5>
                            <ul class="list-group text-left">
                                <ol class="list-group-item">
                                    <li class='list-inline-item text-left'> Waga </li>
                                    <li class='list-inline-item float-right'> {$zakup.weight}  </li>
                                </ol>
                                <ol class="list-group-item">
                                    <li class='list-inline-item'> Śr waga sztuki </li>
                                    <li class='list-inline-item float-right'>{$zakup.avgWeight} </li>
                                </ol>
                                <ol class="list-group-item">
                                    <li class='list-inline-item'> Waga WBC / żywa </li>
                                    <li class='list-inline-item float-right'>  {$zakup.kosztMiesa}  </li>
                                </ol>
                                <ol class="list-group-item">
                                    <li class='list-inline-item'> % </li>
                                    <li class='list-inline-item float-right'>  {$zakup.deduction}%  </li>
                                </ol>

                            </ul>
                        </div>
                    </div>
                </div>   
                <!--endcol-->

                <div class='col-3'>
                <table class='table table-bordered'></table>
                        <div class="card" style='height:100%;'>
                        <div class="card-body">
                            <h5 class="card-title text-left"> Cena / Koszty </h5>
                            <ul class="list-group text-left">
                                <ol class="list-group-item">
                                    <li class='list-inline-item text-left'> Cena </li>
                                    <li class='list-inline-item float-right'> {$zakup.price}  </li>
                                </ol>
                                <ol class="list-group-item">
                                    <li class='list-inline-item'> Koszty transportu</li>
                                    <li class='list-inline-item float-right'>  {$zakup.koszty} </li>
                                </ol>
                            </ul>
                        </div>
                    </div>
                </div>  
                
                <div class='col-3'>
                    <table class='table table-bordered'></table>
                        <div class="card" style='height:100%;'>
                            <div class="card-body">
                                <h5 class="card-title text-left">Dane Klienta</h5>
                                <ul class="list-group text-left">
                                    <ol class="list-group-item">
                                        <li class='list-inline-item text-left'> Klient </li>
                                        <li class='list-inline-item float-right'> {$zakup.client} </li>
                                    </ol>
                                    <ol class="list-group-item">
                                        <li class='list-inline-item'> Grupa </li>
                                        <li class='list-inline-item float-right'> {$zakup.grupa}  </li>
                                    </ol>
                                    <ol class="list-group-item">
                                        <li class='list-inline-item'> Nr tel </li>
                                        <li class='list-inline-item float-right'> {$zakup.kontakt} </li>
                                    </ol>
                                    <ol class="list-group-item">
                                        <li class='list-inline-item'> Adres </li>
                                        <li class='list-inline-item float-right'> {$zakup.address}   </li>
                                    </ol>
                                    <ol class="list-group-item">
                                        <li class='list-inline-item'> Opiekun </li>
                                        <li class='list-inline-item float-right'>  {$zakup.opiekun} </li>
                                    </ol>

                                </ul>
                            </div>
                        </div>
                </div>  
            </div>
            {/foreach}
        </div>
        {/foreach}
        <!-- div BLOCK -->
    </div>
</div>

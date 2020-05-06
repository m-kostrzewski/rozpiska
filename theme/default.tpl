<div class='container'>
    {$my_form_open}
    <div style='text-align:left;margin-left:3%;'>
        {foreach from=$my_form_data item=f}
            {if is_array($f) && isset($f.type) && isset($f.html) && isset($f.label) && $f.type!='hidden' && $f.type!='button' && $f.type!='submit'}
                <b>{$f.label}</b>
                <span class='form-control-input'> {$f.html} </span>
            {/if}
        {/foreach}
         <span class='form-control-btn'> {$my_form_data.submit.html} </span>
         <h1> {$prev} Dzień: {$data.dateFilter} {$next} </h1> 
        </div>
    {$my_form_close}

    <div style='margin-top:2%;margin-left:5%;text-align:left;'>
    <div>
        <select class='customSelect' id='changeTransport'>
            {foreach from=$transportsSelect item=select}
                <option value='{$select.id}'> {$select.name} </option>
            {/foreach}

        </select> 
    </div>

        {foreach from=$transports item=transport}
            {if ($transport === reset($transports))}
                <div class='transport display' id='{$transport.id}'> 
            {else}
                <div class='transport hidden' id='{$transport.id}'>
            {/if}
                 <div style='margin-top:4%;'></div>
                 <div style='width:96%;'>
                    <table class='zakup'>
                        <tr>
                            <td class='bold'> Dzień: </td>
                            <td class='bold'> {$transport.date} </td>
                            <td class='bold' > {$transport.day}, </td>
                        </tr>
                        <tr>
                            <td class='header bold' style='color:red;'> Numer Tr. / do Kogo </td>
                            <td class='header bold' style='color:red;'> Ilość / warunki </td>
                            <td class='header bold' style='color:red;'> Waga rozł. / ubytek </td>
                            <td class='header bold' style='color:red;'> Kierowca </td>
                            <td class='header bold' style='color:red;'>Samochód </td>
                            <td class='header bold' style='color:red;'> Km. Plan </td>
                            <td class='header bold' style='color:red;'> Km. Rzecz </td>
                            <td class='header bold' style='color:red;'> % </td>
                            <td class='header bold' style='color:red;'> Koszty Tr </td>
                            <td class='header bold' style='color:red;width:12%;'> Uwagi </td>
                        </tr>
                        <tr>
                            <td class='' style='color:red;'> Ubojowy </td>
                            <td class='' style='color:red;'> Ilość </td>
                            <td class='' style='color:red;'> Waga załądunku </td>
                            <td class='' style='color:red;'> Grupa / Klient numer telefonu </td>
                            <td class='' style='color:red;'> Adres odbioru (klienta) <br> OP: Opiekun <br> DOK: VAT/RR </td>
                            <td class='' style='color:red;'> Cena </td>
                            <td class='' style='color:red;'> Wyliczenia </td>
                            <td class='' style='color:red;'>  </td>
                            <td class='' style='color:red;'>  </td>
                            <td class='' style='color:red;width:12%;'>  </td>
                        </tr>
                        <tr>
                            <td class='header bold data'> {$transport.number} </td>
                            <td class='header bold data' > 
                                Rozł: {$transport.iloscrozl} <br> 
                                Warunki: {$transport.iloscwaru} <br> 
                                Padłe: {$transport.iloscpadle} <br> 
                            </td>
                            <td class='header bold data'> 
                                Waga: {$transport.weight} <br> 
                                Ubytek: 0 <br> 
                            </td>
                            <td class='header bold data'> {$transport.driver_1} </td>
                            <td class='header bold data'>  {$transport.vehicle}  </td>
                            <td class='header bold data'>    </td>
                            <td class='header bold data'> {$transport.kmprzej} </td>
                            <td class='header bold data'>    </td>
                            <td class='header bold data'>    </td>
                            <td class='header bold data' style='width:12%;'>  {$transport.note}  </td>

                        </tr>
                        {foreach from=$transport.zakupy item=zakup}
                            <tr>
                                <td class='data'> {$zakup.numer_ubojowy} </td>
                                <td  class='data'> 
                                    Plan: {$zakup.amount} <br> 
                                    Zał: {$zakup.sztukzal} <br> 
                                </td>
                                <td class='data'> 
                                    Waga: {$zakup.weight}  <br> 
                                    Śr waga sztuki: {$zakup.avgWeight}  <br> 
                                </td>
                                <td class='data'> 
                                    <span style='color:#145214;'> GRUPA: {$zakup.grupa}  </span> <br>
                                    <span style='color:#2385bf;'> KLIENT: {$zakup.client} </span> <br>
                                    <span> {$zakup.kontakt} </span>
                                </td>
                                <td class='data'>  
                                    {$zakup.address} <br>
                                    {$zakup.opiekun}  <br>
                                </td>
                                <td class='data'>  {$zakup.price}  </td>
                                <td class='data'>  {$zakup.kosztMiesa} </td>
                                <td class='data'> {$zakup.deduction}%  </td>
                                <td class='data'>  {$zakup.koszty} zł </td>
                                <td  class='data' style='width:12%;'>  
                                    Transport: {$zakup.noteTransport} <br> 
                                    Handlowa: {$zakup.noteHandlowiec} <br> 
                                    Kierowca: {$zakup.noteDriver} 
                                </td>
                            </tr>
                        {/foreach}
                    </table>
                </div>
            </div>
         {/foreach} 
        </div>
    </div>

</div>




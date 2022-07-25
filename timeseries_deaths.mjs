import util from 'util'
import { exec } from 'child_process'
const execAsync = util.promisify(exec);

const makeDate = (m, d, y) => {
  const date = new Date()
  date.setDate(d)
  date.setMonth(m - 1)
  date.setYear(y)
  return date
}

const makeDateString = (date) => {
  const m = (date.getMonth() + 1).toString().padStart(2, '0')
  const d = (date.getDate()).toString().padStart(2, '0')
  return `${m}/${d}/${date.getFullYear()}`
}

const makeFileDateString = (date) => {
  const m = (date.getMonth() + 1).toString().padStart(2, '0')
  const d = (date.getDate()).toString().padStart(2, '0')
  return `${date.getFullYear()}${m}${d}`
}
const addDays = (date, days) => new Date(date.getTime() + days * 24 * 60 * 60 * 1000)

const startDate = makeDate(1, 1, 2021)
const endDate = makeDate(7, 15, 2022)
let date = startDate

while (date < endDate) {
  const sDate = date
  date = addDays(date, 1)
  console.log(`Processing: ${date}`)
  const outfile = `./out/weekly/covid_deaths_vaccine_us_` +
    `${makeFileDateString(sDate)}_${makeFileDateString(date)}`
  const cmd = `mysql -h 127.0.0.1 -u root owid ` +
    `-e "SET @end_date = '${makeDateString(date)}'; ` +
    `\\. query/covid_deaths_vaccine_us_n.sql" >${outfile}.tsv`
  await execAsync(cmd)
  const cmd2 = `make-chart --infile ${outfile}.tsv ` +
    `--outfile ${outfile}.png` +
    ` --title 'COVID-19 Deaths vs Vaccination Level [USA]'` +
    ` --subtitle 'Time Frame: ${makeDateString(addDays(sDate, -28))}-` +
    ` ${makeDateString(sDate)}; Source: OWID, CDC; Created by: @USMortality'` +
    ` --xtitle 'Average COVID-19 Vaccinated (Fully)'` +
    ` --ytitle 'Weekly COVID-19 Deaths per Million'` +
    ` --type scatter` +
    ` --xcolumnkey 'series_complete_pop_pct'` +
    ` --ycolumnkey 'total_death_per_million_per_week'` +
    ` --labelcolumnkey 'state'` +
    // ` --yaxistype 'linear'` +
    ` --yaxismin 0` +
    ` --yaxismax 300` +
    ` --xaxismin 0` +
    ` --xaxismax 1`
  await execAsync(cmd2)
}

const cmd3 = `ffmpeg -hide_banner -loglevel error -r 30 -pattern_type glob -i './out/weekly/*.png' -c:v libx264 -vf "fps=60,format=yuv420p,scale=1200x670" ./out/weekly/_movie.mp4`
await execAsync(cmd3)

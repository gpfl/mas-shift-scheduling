# Shift Scheduling using a Multi-agent System over Contract Net Interaction Protocol

<style>
img[src*='#center'] { 
    display: block;
    margin: auto;
}    
</style>

Shift scheduling of workforce is a economic relevant topic for many companies, and still a relevant challenge considering different types of work contract, flexible hours and employee satisfaction. This paper presents a solution for the problem of shift scheduling using a Multi-agent System with Contract Net Protocol communication. We tested our system in a scenario of multiple staff agents, in three different roles, accepting or refusing proposals of shifts initiated by a manager agent.

## Methodology
We propose a methodology based on Multi-agent Systems (MAS) with Contract Net Protocol communication, in which a manager agent starts a process of proposal bidding for work shifts and the other participants are required to issue a propose or refuse that call for each shift and workday based on their restrictions of availability. 
![Contract Net Implementation](img/cnp_implementation.png#center "Contract Net Implementation")

## Results of the Simulation
Considering a full week of shifts, we conducted a simulation for 29 agents (one manager and 28 staff personnel), where each member of staff could apply to one of three different roles. All protocols ended successfully, with agents accepting or refusing the proposals considering their initial availability. Our methodology was able to plan over the entire week horizon, allocating personnel for each shift initially considered. 
![Shift Scheduling Results](img/cnp_results.png#center "Shift Scheduling Results")

---
description: General diagram for app architecture
order: 1
---

# Overview

In simple words, below we can find the application architecture diagram


```mermaid
flowchart BT
  
  Entities --> Repositories
  Entities --> Pages

  subgraph Entities
    E1
    E2
    E3
    E4
    E..
    En
  end

  
  subgraph Pages
    subgraph P1
      direction TB
      
      subgraph F1
        direction TB
        BLoC1 --state--> UI1
        UI1 --events--> BLoC1
      end

      subgraph F2
        direction TB
        BLoC2 --state--> UI2
        UI2 --events--> BLoC2
      end
      
    end
    subgraph P2
      direction TB
      
      subgraph F3
        direction TB
        BLoC3 --state--> UI3
        UI3 --events--> BLoC3
      end
    end
  end

  BLoC1 -.-> Repositories
  Repositories -.-> BLoC1
  BLoC2 -.-> Repositories
  Repositories -.-> BLoC2
  BLoC3 -.-> Repositories
  Repositories -.-> BLoC3
  
  subgraph Repositories
    R1
    R2
    R3
    R4
    R..
    Rn
  end

```
* Mainly we have the pages, and each page is a screen that will be presented to the user (Ex.: Log in page, Home page, User profile page, etc.).
* A page can have one or more features (Ex.: Home page has three features: next class, which is related to the schedule; average grade per course, which is related to courses and enrollment; and pending payments, related to the payments.).
* Every feature has its ui (widgets), its BLoC and its definition of events and state to use with the BLoC.